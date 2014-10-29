package vongola 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class StateMachine 
	{
		private var states : Dictionary = new Dictionary();
		private var currentState : int = -1;
		
		public function StateMachine()
		{
			
		}
		
		public function getState() : int { return currentState; }
		
		public function createState( state : int, onEnter : Function = null, onUpdate : Function = null, onExit : Function = null)  : void
		{
			states[state] = new State(onEnter, onUpdate, onExit);
		}
		
		public function updateState( state : int, onEnter : Function = null, onUpdate : Function = null, onExit : Function = null) : void
		{
			var stateObj : State = states[state];
			if ( stateObj != null )
			{
				if( onEnter != null)
					stateObj.onEnter = onEnter;
				if (onUpdate != null)
					stateObj.onUpdate = onUpdate;
				if (onExit != null )
					stateObj.onExit = onExit;
			}
		}
		
		public function setState( state : int ) : void
		{
			var prevState : int = currentState;
			currentState = state;
			if ( prevState != -1)
			{
				states[prevState].exit();
			}
			if (state != -1 && states[state] != null)
				states[state].enter();
		}
		
		public function update() : void
		{
			if (currentState != -1 && states[currentState] != null)
			{
				states[currentState].update();
			}
		}
	}

}

class State
{
	public var onEnter : Function;
	public var onUpdate : Function;
	public var onExit : Function;
	
	public function State( enterFunc : Function, updateFunc : Function, exitFunc : Function )
	{
		onEnter = enterFunc;
		onUpdate = updateFunc;
		onExit = exitFunc;
	}
	
	public function enter():  void
	{
		if (onEnter != null)
			onEnter();
	}
	
	public function update() : void
	{
		if (onUpdate != null)
			onUpdate();
	}
	
	public function exit() : void
	{
		if (onExit != null)
			onExit();
	}
}