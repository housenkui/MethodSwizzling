# MethodSwizzling
在+(void)load中使用方法调和不带有返回值的函数，
但是带有返回值的为什么交换不了啊？
比如我想在解析NSDictionary的时候，如果所得对象是nil，给一个提示。方法调和objectForKey:
