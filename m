From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: mutexes and preemption
Date: Wed, 3 Mar 2004 15:59:20 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <CFF522B18982EA4481D3A3E23B83141C01C9885D@orsmsx407.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Seifert <lathander-Mmb7MZpHnFY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



One of these ACQUIRE ops timed out:                     =20

Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0x8FFF)

As witnessed by this debug output:

Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|0], AE_TIME
Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|36863], AE_TIME

Notice that the ASL code does not handle the AE_TIME error case but just
plows ahead.

Bob





-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Sebastian
Seifert
Sent: Tuesday, March 02, 2004 2:51 PM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] mutexes and preemption

Hello,

some vital information first: I'm using kernel 2.6.3-mm4 with DSDT in
ramdisk
patch applied, preemption is enabled, SMP disabled.=20

I'm currently debugging the DSDT of my laptop (Benq Joybook 5000). Some
ACPI
method calls seem to be failing because of double acquisition of a
mutex. One
reproducible way to trigger the problem is to read the ac adapter's
state.  My
syslog looks like this (I set debug_level to 31 and added printks in
exoparg?.c):

Mar  2 23:03:10 tenshi kernel: Execute Method: [\_SB_.AC__._PSR] (Node
dff60f88)
Mar  2 23:03:10 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1370
(55A)
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2016] acpi_ec_read
: Read [08] from address [92]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2022] acpi_ec_read
: Read [30] from address [9c]
Mar  2 23:03:10 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 1370
(55A)
Mar  2 23:03:10 tenshi kernel: exregion-0294 [2030]
ex_system_io_space_han: system_iO 1 (8 width) Address=3D00000000000000B3
Mar  2 23:03:10 tenshi kernel: exregion-0294 [2030]
ex_system_io_space_han: system_iO 1 (8 width) Address=3D00000000000000B2
Mar  2 23:03:10 tenshi kernel:   evmisc-0121 [2021]
ev_queue_notify_reques: Dispatching Notify(81) on node dff61ca8
Mar  2 23:03:10 tenshi kernel:   evmisc-0137 [2021]
ev_queue_notify_reques: Notify value: Status Change
Mar  2 23:03:10 tenshi kernel: Execute Method: [\_TZ_.THZN._TMP] (Node
dff61c48)
Mar  2 23:03:10 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 1370
(55A)
Mar  2 23:03:10 tenshi kernel: AML_ACQUIRE_OP on [MUT1] by thread 3 (3)
Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|0], AE_TIME
Mar  2 23:03:10 tenshi kernel:      osl-0909 [2049] os_wait_semaphore
: Failed to acquire semaphore[dffd8680|1|36863], AE_TIME
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2054] acpi_ec_read
: Read [30] from address [9c]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2054] acpi_ec_read
: Read [28] from address [9d]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2054] acpi_ec_read
: Read [3c] from address [9e]
Mar  2 23:03:10 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 3 (3)
Mar  2 23:03:10 tenshi kernel:  exmutex-0264: *** Error: Thread 3 cannot
release Mutex [MUT1] acquired by thread 55A
Mar  2 23:03:10 tenshi kernel:  psparse-1120: *** Error: Method
execution failed [\_TZ_.THZN._TMP] (Node dff61c48), AE_AML_NOT_OWNER
Mar  2 23:03:10 tenshi kernel: acpi_utils-0256 [2036]
acpi_evaluate_integer : Evaluate [\_TZ_.THZN._TMP]: AE_AML_NOT_OWNER
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2034] acpi_ec_read
: Read [28] from address [9d]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0230 [2036] acpi_ec_write
: Wrote [28] to address [9d]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2045] acpi_ec_read
: Read [3c] from address [9e]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0230 [2050] acpi_ec_write
: Wrote [3c] to address [9e]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0178 [2058] acpi_ec_read
: Read [32] from address [a0]
Mar  2 23:03:10 tenshi kernel:  acpi_ec-0230 [2063] acpi_ec_write
: Wrote [28] to address [a0]
Mar  2 23:03:10 tenshi kernel: AML_RELEASE_OP on [MUT1] by thread 1370
(55A)
Mar  2 23:03:10 tenshi kernel: exregion-0372 [2072]
ex_pci_config_space_ha: pci_config 0 (8) Seg(0000) Bus(0000) Dev(001f)
Func(0000) Reg(00a0)
Mar  2 23:03:10 tenshi kernel: exregion-0372 [2072]
ex_pci_config_space_ha: pci_config 1 (8) Seg(0000) Bus(0000) Dev(001f)
Func(0000) Reg(00a0)
Mar  2 23:03:10 tenshi kernel: acpi_utils-0267 [2054]
acpi_evaluate_integer : Return value [1]

_PSR acquires MUT1, reads some registers, then releases it.  Then, it
calls
some method CHGT (not indicated by debug output, but I know from the
DSDT),
which possibly changes some temperature trigger values, and Notifies the
thermal zone.  Then, it calls some method STEV, which acquires MUT1,
does
something, and releases it.

What seems to happen is that the Notify enqueues an event for later
processing
by thread 3, an event daemon.  Then, during the execution of STEV, which
has
acquired MUT1, thread 1370 (in above example syslog) becomes preempted
(it
seems). The event handler runs and tries to process the notification.
Which
involves reading the temperature by calling _TMP, which tries to acquire
the
same mutex MUT1. At least that's my analysis. If I disable kernel
preemption,
the second release of MUT1 by the running thread happens before the
acquire by
thread 3 and no error happens.

Now, I'm not sure what that means. Is preemption in combination with
ACPI
unsupported? Is it legal to schedule away from a thread that is holding
an ACPI
mutex?  Or is the way the mutex is used inside my DSDT invalid?  The
DSDT looks
good to my eye, the mutex is only held for some lines of code while
accessing
the embedded controller. But I don't know much about ACPI and the
assumptions
that are made.

Another problem I'm having is that the OS does not seem to execute the
_REG
method of my embedded controller. I'm circumventing this problem by
setting the
controller's activation flag to 1 all the time, and faking values in
_STA
methods (which are called during initialization while there is no
embedded
controller operation region yet). But shouldn't _REG be called when the
operation region becomes enabled?

Thanks in advance,
Sebastian

Some relevant parts of my DSDT:=20
    Method (CHGT, 1, NotSerialized)
    {
        Store (Arg0, TMOD)
        If (LEqual (Arg0, 0x00))
        {
            Store (MTPB, CTPB)
            \_SB.GSMI (0x18)
            Sleep (0x64)
            Store (0x00, TRON)
            Store (CTTP, PTMP)
        }

        If (LEqual (Arg0, 0x02))
        {
            Store (BTPB, CTPB)
            Store (PASH, PTMP)
        }

        Notify (\_TZ.THZN, 0x81)=20
    }

    Method (STEV, 1, NotSerialized)
    {
        CreateByteField (CTPB, 0x00, TPL0)
        CreateByteField (CTPB, 0x01, TPH0)
        [...lots of conditional Stores...]
        Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0x8FFF)
        Store (TMPL, \_SB.PCI0.LPCB.EC0.LTMP)
        Store (TMPH, \_SB.PCI0.LPCB.EC0.HTMP)
        Store (CFSP, \_SB.PCI0.LPCB.EC0.FANS)
        Release (\_SB.PCI0.LPCB.EC0.MUT1)
    }

	ThermalZone (THZN)
        {
            Method (_TMP, 0, Serialized)
            {
                If (ECON)
                {
                    Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0x8FFF)
                    Store (\_SB.PCI0.LPCB.EC0.CCPT, Local0)
                    Store (\_SB.PCI0.LPCB.EC0.LTMP, Local1)
                    Store (\_SB.PCI0.LPCB.EC0.HTMP, Local2)
                    Release (\_SB.PCI0.LPCB.EC0.MUT1)
                    If (LOr (LNot (LEqual (TMPL, Local1)), LNot (LEqual
(TMPH, Local2))))
                    {
                        STEV (Local0)
                    }

                    Add (Local0, 0x0111, Local0)
                    Multiply (Local0, 0x0A, Local0)
                    Return (Local0)
                }
                Else
                {
                    Return (0x0C80)
                }
            }
	    [...]
        }
	[...]
	Device (AC)=20
        {
	    [...]
            Method (_PSR, 0, NotSerialized)
            {
                If (LEqual (DFEC, 0x00))
                {
                    If (ECON)
                    {
                        Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0x8FFF)
                        Store (\_SB.PCI0.LPCB.EC0.ACST, Local0)
                        Store (\_SB.PCI0.LPCB.EC0.CCPT, Local1)
                        Release (\_SB.PCI0.LPCB.EC0.MUT1)

                        If (LEqual (Local0, 0x01))
                        {  =20
                            CHGT (0x00)
                            STEV (Local1)
                            Store (0x00, \_SB.PCI0.LPCB.C4C3)
                        }
                        Else
                        {
                            CHGT (0x02)
                            STEV (Local1)
                            Store (0x01, \_SB.PCI0.LPCB.C4C3)
                        }

                        Return (Local0)
                    }
                    Else
                    {
                        Return (One)
                    }
                }
                Else
                {
                    Return (One)
                }
		/* this seems to be bogus - never reached ??
                Store (0xA0, MLIN)
                Store (MLDT, Local0)
                If (LEqual (Local0, 0x77))
                {
                    Return (0x01)
                }

                Acquire (\_SB.PCI0.LPCB.EC0.MUT1, 0x8FFF)
                Store (\_SB.PCI0.LPCB.EC0.PBAC, Local0)
                Release (\_SB.PCI0.LPCB.EC0.MUT1)
                Return (Local0)
		*/
            }


--=20
"Gott ist tot."
	--Nietzsche
"Nietzsche ist tot."
	--Gott


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
