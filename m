From: Rich Ibbotson <richibb-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: ACPI/ECDT on gateway 200x notebook
Date: Sat, 03 Jan 2004 21:01:09 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FF773E5.5070102@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Dear ACPI Gurus,

I'm trying to get ACPI working on a Gateway 200X (200ARC) notebook
running Linux with kernel 2.4.23 (built from sources).  The specs for
this notebook claim that it has APM 1.2 and ACPI 2.0 support.  However,
when I run a kernel with ACPI enabled (as a module) the
/proc/acpi/battery and /proc/acpi/ac_adapter directories are both empty
and I see these messages at boot time:

  kernel:     ACPI-1120: *** Error: Method execution failed 
[\_SB_.ADP1._STA] (Node c12f88c0), AE_AML_NO_RETURN_VALUE
  kernel:     ACPI-1120: *** Error: Method execution failed 
[\_SB_.BAT1._STA] (Node c12f89c0), AE_AML_NO_RETURN_VALUE

I see that this has been discussed here before, and it looks like the
consensus is that I need to manually install an ECDT at boot time.

The latest discussions of this problem that I've seen are here:
http://sourceforge.net/mailarchive/forum.php?thread_id=3451648&forum_id=6102
http://sourceforge.net/mailarchive/forum.php?thread_id=3479606&forum_id=6102

After reading those threads, I've tried two things to get ACPI working:

1) Patch the latest 2.4.23 kernel sources with acpi-20031203-2.4.23.diff
and the "fake_ecdt" patch from Ducrot Bruno, passing the string
"ecdt_fake=0x66:0x62:28:1:\\_SB_.PCI0.LPCB.H_EC" to the kernel at boot
time (my _GPE is 0x1c and the _UID reported by acpidmp under Device H_EC
is 0x01)

I see that the fake ecdt does not work, but I am not sure why.  I see
nothing between the following two logs:

  kernel: ACPI: Faking ECDT
  kernel: ACPI: Could not use ECDT

If I specify the path as "\_SB_.PCI0.LPCB.H_EC" (only one "\") in my
grub.conf, I see the following:

  kernel: ACPI: Faking ECDT
  kernel: evregion-0347: *** Error: Handler for [EmbeddedControl]
returned AE_BAD_PARAMETER
  kernel:  dswexec-0435 [11] ds_exec_end_op        : [Store]: Could not
resolve operands, AE_BAD_PARAMETER
  kernel:  psparse-1120: *** Error: Method execution failed
[\_SB_.PCI0.LPCB.H_EC._REG] (Node c13f6c68), AE_BAD_PARAMETER
  kernel: ACPI: Could not use ECDT

I do see an entry for "\_SB_.PCI0.LPCB.H_EC._REG" in the DSDT, though:

000028c5:         Method _REG (\_SB_.PCI0.LPCB.H_EC._REG)
000028cb:           ArgCount 2; NotSerialized
000028cc:           If
000028ce:             LAnd
000028cf:               LEqual
000028d0:                 Arg0
000028d1:                 0x03
000028d3:               LEqual
000028d4:                 Arg1
000028d5:                 0x01
000028d7:             Store
000028d8:               0x01
000028da:               ECON (0000024e)
000028de:             Store
000028df:               \_SB_.PCI0.LPCB.H_EC.ACEX (00002844)
000028f6:               \PWRS (00000160)

I'm not sure if this means that it got a little further, or if this is
an error because I should have used both backslashes.

2) I would like to try actually supplying an ECDT, using the information
below (I got much of this from the DSDT, but I'm not sure if the Creator
ID/Creator Revision matter).  Is there a suggested way to put this into
a char[] or some form that can be used in acpi_os_table_override?  If I
can get it into a char[] then I guess I can calculate the checksum and
length, but if not then how do I compute these?

    ECDT: Length=?, Revision=1, Checksum=?,
          OEMID=INTEL, OEM Table ID=MONTARAG, OEM Revision=0x06040000,
          Creator ID=fake, Creator Revision=0x1
          EC_CONTROL=0x66:0[8] (IO)
          EC_DATA=0x62:0[8] (IO)
          UID=1, GPE_BIT=0x1c
          EC_ID=\_SB_.PCI0.LPCB.H_EC


thanks for any advice,
Rich





-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
