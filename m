From: Pierre Letouzey <Pierre.Letouzey-CYrOEBX6jiM@public.gmane.org>
Subject: strange behavior of ArgX variables in a ASL method
Date: Tue, 26 Aug 2003 18:22:33 +0200 (MEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0308261730040.17349-100000@pc8-142>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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



Hello all

First, a big thanks to the acpi developers: by following your web pages
I finally managed to get nearly everything working on my Evo N800c,
especially battery information and swsuspd (after patching my radeon
driver according to http://cpbotha.net/dri_resume.html).

I currently use the DSDT comming from your web page:
	 Compaq-Evo_N800v-F.18A-custom.asl
But this ASL code produces some remaining errors:

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 (bios) S4 S5)
dsopcode-0515 [20] ds_init_buffer_field  : Field size 1184 exceeds Buffer size 1088 (bits)
 psparse-1121: *** Error: Method execution failed [\_SB_.C03C.C048] (Node c185a528), AE_AML_BUFFER_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.C03C.C04C] (Node c185a628), AE_AML_BUFFER_LIMIT
 psparse-1121: *** Error: Method execution failed [\_SB_.C03C._CRS] (Node c185a728), AE_AML_BUFFER_LIMIT
  uteval-0098: *** Error: Method execution failed [\_SB_.C03C._CRS] (Node c185a728), AE_AML_BUFFER_LIMIT

The problem is in this method (line 470):

 1            Method (C048, 4, NotSerialized)
 2            {
 3               Store (Arg1, Local2)
 4                Store (Arg3, Local4)
 5               Add (Local4, 0x1A, Local5)
 6               While (LLess (Local4, Local5))
 7               {
 8                   Store (DerefOf (Index (C046, Local4)), Index (Arg0, Local2))
 9                   Increment (Local4)
10                    Increment (Local2)
11                }
12
13                Store (Arg1, Local2)
14                Add (Local2, 0x0A, Local2)
15                CreateDWordField (Arg0, Local2, C049)
                  ....

After printing the values of some variables, I figured out the following
scenario:

- Line 3: first Local2 gets the value of Arg1
- Line 6-11: the While loop adds 0x1A to Local2 in total.
- Line 13: this do NOT put back the initial value of Arg1 in Local2.
    Via a debug print of Arg1, I learned that Arg1 has in fact also been
    increased by 0x1A since beginning of the method.
- Line 15: Local2, too big by 0x1A, is out of the bound of buffer Arg0,
    hence the error messages.

I tried to replace the second Store(Arg1, Local2) by a
Substract(Local2, 0x1A, Local2), and that makes the errors disappear.

So it seem that the behavior of Store(Arg1, Local2) is to make the two
variables physicaly equal (at the pointer level ?), instead of just
copying the Arg1 value in Local2. And it seems that the Compaq DSDT
expects the other behavior. It reminds me of the Call-by-name /
Call-by-value duality in my earlier computer science courses...
I had a look at the ACPI specs but I didn't find which behavior is correct.

A pragmatic solution might be to patch the .asl file with this
Substract instead of the Store ...



Btw, my complete config is:

Compaq Evo N800c, Bios revision F.1D
Kernel 2.4.21 with ACPI patch 20030619
DSDT compiled from your Compaq-Evo_N800v-F.18A-custom.asl

Note: N800c and N800v are close enough, according to
        http://www.ailis.de/~k/knowledge/evon800c/

Pierre Letouzey

PS: I tried 2.6.0-test3 and S3 sleep. Stops ok, but black screen at wake
up. I know from the "make menuconfig" help of CONFIG_ACPI_SLEEP that it
is not ready yet, but this Suspend-to-RAM would really be cool...
How can I (modestly) help ?

PPS: One more thing, when I swap the dvd/cdrom multibay with the
additional battery, this battery is sometimes seen as not present by ACPI.
And when swapping back to dvd/cdrom, I need to reboot before being able to
mount a cdrom. Not a big deal, just slightly annoying.




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
