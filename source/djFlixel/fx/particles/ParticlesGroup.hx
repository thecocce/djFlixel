package djFlixel.fx.particles;

import flixel.FlxSprite;
import flixel.group.FlxGroup;


// --
typedef _ParticleJsonPAnims = {
	name:String,
	frames:Array<Int>,
	fps:Int
}
// --
typedef _ParticleJsonParams = {
	height:Int,
	width:Int,
	sheet:String,
	anims:Array<_ParticleJsonPAnims>
}

/**
 * Particle Group for Generic particles
 * Can be used to create and handle generic particles
 * ------------------------------------------
 *  + Supports one spriteSheet and one class
 * 
 */
class ParticlesGroup extends FlxTypedGroup<ParticleGeneric>
{
	
	// Keep this many particles in a pool for quick retrieval
	var BUFFER_LEN:Int = 16;

	// Must set this
	var info:_ParticleJsonParams;
	
	//====================================================;

	/**
	 * Create a particle group
	 * @param	particleInfoNode The node name in the JSON params file
	 * @param	buffer Options, create this many particles for recycling
	 */
	public function new(particleInfoNode:String, buffer:Int = 16 )
	{
		super();
		
		// maxSize = 0; Growing style.
		
		BUFFER_LEN = buffer;
		info = Reflect.getProperty(Reg.JSON, particleInfoNode);
		
		// Create some buffer particles
		for (i in 0...BUFFER_LEN)
		{
			var p = new ParticleGeneric(info);
			p.kill();
			add(p);
		}
		
	}//---------------------------------------------------;
	
	// --
	public function createOneAt(x:Float, y:Float, type:String, centerPivot:Bool = false):FlxSprite
	{
		var p:ParticleGeneric = recycle(ParticleGeneric, function() { return new ParticleGeneric(info); } );
		
		if (centerPivot)
		{
			p.setPosition(x - (p.width / 2) , y - (p.height / 2));
		}else
		{
			p.setPosition(x, y);
		}

		p.start(type);
		p.velocity.set(0, 0);
		
		return p;
	}//---------------------------------------------------;
	
	
	/**
	 * 
	 * @param	x World pos
	 * @param	y World pos
	 * @param	type 
	 * @param	numberOfParticles
	 * @param	speedMulti
	 */
	public function createCircular(x:Float, y:Float, type:String, numberOfParticles:Int = 4, speedMulti:Float = 1)
	{
		var baseSpeed:Int = Std.int(75 * speedMulti);
		var r1:Float = 0;
		var r1_step:Float = (2 * Math.PI) / numberOfParticles;
		var r1_third = r1_step / 3;
		var p:FlxSprite;
		
		r1 = Math.random() * r1_step;
	
		for (i in 0...numberOfParticles)
		{
			p = createOneAt(x, y, type, true);
			p.velocity.x = baseSpeed * Math.cos(r1);
			p.velocity.y = baseSpeed * Math.sin(r1);
			r1 += r1_step + Math.random() * (r1_third);
		}
		
	}//---------------------------------------------------;
	
}// --