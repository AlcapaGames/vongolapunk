package vongola
{
	import adobe.utils.CustomActions;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author ...
	 */
	public class AudioManager 
	{
		private static var currentMusic : SoundChannel;
		private static var currentMusicClass : Class;
		private static var sfxs : Vector.<SoundChannel> = new Vector.<SoundChannel>();
		private static var audioMemory : Dictionary = new Dictionary();
	
		public static var AudioIconOn : Class = null;
		public static var AudioIconOff : Class = null;
		
		public static function get AudioEnabled() : Boolean
		{
			Data.load();
			return Data.readBool("AudioEnabled", true);
		}
		
		public static function get AudioIcon() : Class
		{
			return AudioEnabled ? AudioIconOn : AudioIconOff;
		}
		
		private static var kVolumeValue : Number = 1.0;
		
		public static function toggleAudio() : void
		{
			Data.load();
			Data.writeBool("AudioEnabled", !Data.readBool("AudioEnabled", true));
			Data.save();
			SoundMixer.soundTransform = new SoundTransform(AudioEnabled ? kVolumeValue : 0.0);
		}
		
		public static function Init(audioOnGraphic : Class, audioOffGraphic : Class) : void
		{
			AudioIconOn = audioOnGraphic;
			AudioIconOff = audioOffGraphic;
			SoundMixer.soundTransform = new SoundTransform(AudioEnabled ? kVolumeValue : 0.0);
		}
		
		public function AudioManager() 
		{
		}
		
		public static function freeMemory() : void
		{
			currentMusic = null;
			sfxs.splice(0, sfxs.length);
			audioMemory = new Dictionary();
		}
		
		private static function getSound(data : Class) : Sound
		{
			if (audioMemory[data] == null)
			{
				audioMemory[data] = new data();
			}
			return audioMemory[data];
		}
		
		private static function onSoundEffectComplete(e : Event) : void
		{
			for (var i : int = 0; i < sfxs.length; i++)
			{
				if (sfxs[i] == e.target)
				{
					sfxs.splice(i, 1);
				}
			}
		}
		
		public static function playSound(soundFX : Class, loop : Boolean = false) : SoundChannel
		{
			var sound : Sound = getSound(soundFX);
			var soundChannel : SoundChannel = sound.play(0, loop ? int.MAX_VALUE : 0);
			soundChannel.addEventListener("soundComplete", onSoundEffectComplete);
			sfxs.push(soundChannel);
			return soundChannel;
		}
		
		public static function playMusic(musicBG : Class) : void
		{
			if ( currentMusicClass != musicBG)
			{
				if ( musicBG == null )
				{
					if (currentMusic != null)
						currentMusic.stop();	
					currentMusic = null;
					currentMusicClass = null;
				}
				else
				{
					var music : Sound = getSound(musicBG);
					if (currentMusic != null)
					{
						currentMusic.stop();
					}
					currentMusic = music.play(0, int.MAX_VALUE);
					currentMusicClass = musicBG;
				}
			}
		}
		
	}

}