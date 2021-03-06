version(LDC)
{
    import ldc.intrinsics;
    //alias pow = llvm_powi;
    alias pow = llvm_pow;
} else {
    import std.math : pow;
}

void main(string[] args)
{
    import std.datetime: benchmark, Duration;
    import std.stdio: writeln, writefln;
    import std.conv: to;

    auto a = 5.0;
    auto b = 25;
    auto l = 0.0;

    void f0() { l += pow(a, b); }
    void f1() { l += a ^^ b; }

    auto rs = benchmark!(f0, f1)(100_000_000);

    foreach(j,r;rs)
    {
        version(GNU)
            writefln("%d %d secs %d ms", j, r.seconds(), r.msecs());
        else
            writeln(j, " ", r.to!Duration);
    }

    // prevent any optimization
    writeln(l);
}
