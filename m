From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Compaq Evo N610c in almost perfect ACPI support shocker
Date: Wed, 1 Oct 2003 17:35:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031001163539.GA22358@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I've just received a Compaq Evo N610c which I wanted to put Linux on.
I'd previously owned a Presario 2701ea which had a buggy DSDT (usual off
by one errors etc) so was expecting a bit of a bumpy ride.

Kudos to HP/Compaq though, the new BIOS runs almost flawlessly through
Linux's ACPI and the only errors on boot seem to be on the interpreter
side (although I'd love to be proved wrong ;)

One of the problems seems to be long standing - I found a kludge on the
mailing list to fix it:

            Method (C051, 4, NotSerialized)
            {
// Copy Arg1 pointer to Local2 (in theory)
                Store (Arg1, Local2)
                Store (Arg3, Local4)
                Add (Local4, 0x1A, Local5)
                While (LLess (Local4, Local5))
                {
                    Store (DerefOf (Index (C04F, Local4)), Index (Arg0,
Local2))
                    Increment (Local4)
// Nasty side-effect, also increments Arg1
                    Increment (Local2)
                }

// Let's reset Local2 to Arg1 again.. oh dear it's the same value.
//                Store (Arg1, Local2)
// Here comes the kludge
                Subtract (Local2, 0x1A, Local2)
// This was making it go past end of buffer
                Add (Local2, 0x0A, Local2)

As you can see I've applied the Subtract kludge other people have used,
but there's nothing actually wrong with the ASL here AFAICS, it should
work.

The other part may just be ACPI being over-verbose on something it's
handling correctly - I don't think I'm losing any functionality because
of it:

    ACPI-1121: *** Error: Method execution failed
[\_SB_.C045.C059.C0E2.C13F] (N
ode cff95e40), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1121: *** Error: Method execution failed
[\_SB_.C045.C059.C0E2.C14E] (N
ode cff931c0), AE_AML_UNINITIALIZED_LOCAL
    ACPI-1121: *** Error: Method execution failed [\_SB_.C198._BTP]
(Node cff8ec
80), AE_AML_UNINITIALIZED_LOCAL
ACPI: Battery Slot [C198] (battery present)

Here's the DSDT snippet:
                    Method (C13F, 3, Serialized)
                    {
                        Add (Arg2, 0x01, Local3)
                        Store (Buffer (Local3)
                            {
                                0x10
                            }, Local2)
                        Store (0x0A, Local5)
                        Store (0x01, Local1)
// This next line has been added by me to satisfy the parser
						Store (0x00, Local0)

                        While (LAnd (Local1, LGreater (Local5, 0x00)))
                        {
                            Store (C12E (0x00), Local1)
                            If (LNot (Local1))
                            {
                                Store (C12D (Arg0, Arg1), Local1)
                                If (LAnd (LNot (Local1), LGreater (Arg2,
0x00)))
                                {
                                    Store (C12C (Arg0, Arg2), Local0)
                                    Store (DerefOf (Index (Local0,
0x00)), Local
1)
                                }

                                Or (C12F (), Local1, Local1)
                            }

                            Decrement (Local5)
                            If (LAnd (Local1, LGreater (Local5, 0x00)))
                            {
                                Sleep (0x64)
                            }
                        }

                        If (Local1)
                        {
                            Return (Local2)
                        }

// Not initialised if the While loop isn't entered, but if that's the
// case then Local1 is true (1) and this point is not reached.

                        Return (Local0)
                    }

With the kludge I apply above, there are no errors during boot.

Now, onto the HP/Compaq problem I've found (where do I apply for a
ROMPAQ?)  There are only two settings for Intel Speedstep in the BIOS
(fine thought I) Auto and Disabled.  Disabled, as expected, disables the
Speedstep functionality and you see <Not Supported> in
processor...performance.  Good so far.

Auto means that the laptop fully controls the Speedstep functionality
and it cannot be overridden by the OS.  I've tested this by installing
CPUFREQ which accesses speedstep outside of ACPI, configuring it for
60%60%powersave and when running glxgears I get a jump up to the same
FPS I get on 100%100%performance.  I can confirm this for several
seconds afterward with cat /proc/sys/cpu/0/speed showing the maximum cpu
speed.  ACPI is not being informed of the processor state changes and
shows P0: regardless of which P state the laptop is in.

I've just tagged this on because I know there are a few HP/Compaq people
on here and I hope they'll be able to provide a ROMPAQ which at least
exposes "Enabled" or "OS" which would allow the OS to control the
speedstep state (or at least point me in the right direction)
It may also help others who are currently baffled by the behaviour :)

It's currently running F15A BIOS, which appears to be the latest
available on the site.

I'd like to finish by saying that this is the best Compaq laptop I've
ever had and I believe that I have every piece of hardware working on it
(modem unnecessary and untested).  I'd definitely recommend it to the
company I work for if the Speedstep issue can be resolved.

I'll have the usual stuff up on my website when I get around to it :)
(actually precious little because everything is so well supported!)
but in the meantime:

An error free dmesg:
http://dude.noc.clara.net/~faye/evo_n610c/dmesg.txt
The F15A dsdt:
http://dude.noc.clara.net/~faye/evo_n610c/dsdt
The patched dsdt:
http://dude.noc.clara.net/~faye/evo_n610c/dsdt.dsl

I'm going to be moving the site to http://www.zippysoft.com/linux/
some time in the near future.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Of all the animals, the boy is the most unmanageable.
		-- Plato


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
