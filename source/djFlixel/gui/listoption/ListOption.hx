package djFlixel.gui.listoption;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

/**
 * An empty Sprite Group
 * Ready to be extended and inserted into a VList
 * ...
 */
@:generic
class ListOption<T> extends FlxTypedSpriteGroup implements IListOption<T>
{
	
	// Store the focus state
	public var isFocused:Bool;
	// Communicate with a menu
	public var callbacks:String->Void = null;
	//---------------------------------------------------;
	public function new() 
	{
		super();
	}//---------------------------------------------------;
	// --
	public function setData(data:T):Void
	{
	}//---------------------------------------------------;
	public function sendInput(inputName:Dynamic):Void
	{
	}//---------------------------------------------------;
	public function focus():Void
	{
	}//---------------------------------------------------;
	public function unfocus():Void
	{
	}//---------------------------------------------------;
	public function getOptionHeight():Int
	{
		return 0;
	}//---------------------------------------------------;
	public function isSame(data:T):Bool
	{
	}//---------------------------------------------------;
	
	//====================================================;
	// - SYSTEM - 
	//====================================================;
	// -- 
	// - GroupAlpha is broken, so do it manually... :/
	override private function set_alpha(Value:Float):Float 
	{
		if (Value < 0) Value = 0;
		if (Value > 1) Value = 1;
		for (i in group) { i.alpha = Value; }
		return alpha = Value;
	}//---------------------------------------------------;
	
}// -- end -- //