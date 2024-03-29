import {assert,expect,test} from "vitest"

test "Math.sqrt()", do
	expect(Math.sqrt(4)).toBe 2
	expect(Math.sqrt(144)).toBe 12
	expect(Math.sqrt(2)).toBe Math.SQRT2

test "JSON", do
	const input = 
		foo: "hello"
		bar: "world"
	const output = JSON.stringify(input)
	expect(output).toBe '{"foo":"hello","bar":"world"}'
	assert.deepEqual JSON.parse(output), input, "matches original"
