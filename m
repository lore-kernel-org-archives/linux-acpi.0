From: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Subject: ASL help with latest acpi and compaq presario 2800t
Date: Sun, 9 Feb 2003 17:51:28 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030210005130.2018.qmail@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings. 

I have been running nicely on my presario 2800t for a while, but with
kernel 2.4.18 and a pretty old acpi version. 

So, what better to do on a lazy sunday than try and upgrade to
2.4.21-pre4 and the newest acpi? :) 

I pulled down the 2.4.21-pre4 kernel. Applied the
acpi-20030125-2.4.21-pre3.diff.gz diff to it. 
Then applied the patch-acpi-acpi20030125-swsusp18.gz software
suspend+acpi patch to that. 

First I tried just compiling that and seeing how acpi would work. 
It came up, but of course with no battery/ac, etc due to the broken
compaq dsdt. 

So, I pulled down acpidump and iasl-linux-20030123.tar.gz
dumped out the dsdt and tried to compile it. 

56 errors. 

I first fixed all the "String must be entirely alphanumeric" errors
(compaq seems to like putting * in all their names.)
I realize it's against the spec, but could something be added to
change * to nothing if it finds it in a Name? 

Fixing those got me down to 21 errors. 
(Worth noting that at this point with the old iasl I was using with
2.4.18 there were no further errors here). 

Any ideas on any of these:

dsdt.asl-2003-02-09   168:                 If(\_OSI) {
Error    1028 -                 Too few arguments ^  (\_OSI requires 1)
dsdt.asl-2003-02-09   169:                     "Windows 2001"
Error    1037 -                                             ^ parse error, unexpected PARSEOP_STRING_LITERAL
dsdt.asl-2003-02-09  1918:                         Method(_OFF) {
Warning  2019 -         Not all control paths return a value ^  (_OFF)
dsdt.asl-2003-02-09  2206:                         Method(_OFF) {
Warning  2019 -         Not all control paths return a value ^  (_OFF)
dsdt.asl-2003-02-09  2291:                 Name(_HID, "*SYN0100")
Error    1068 -           String must be entirely alphanumeric ^  (*SYN0100)
dsdt.asl-2003-02-09  3293:         Store(DerefOf(Index(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg1), )), Local0, )), Local1, )), Local2)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3318:         Subtract(C1BA, 0x0aac, Local1)
Error    1022 -          Object does not exist ^  (C1BA)
dsdt.asl-2003-02-09  3321:         Subtract(C1BB, 0x0aac, Local1)
Error    1022 -          Object does not exist ^  (C1BB)
dsdt.asl-2003-02-09  3362:                 Store(Match(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg0), )), 0x1, )), MGT, Local1, MTR, 0x0, 0x0), Local0)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3365:                 Store(Match(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg0), )), 0x0, )), MGT, Local1, MTR, 0x0, 0x0), Local0)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3385:         Store(DerefOf(Index(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg1), )), 0x1, )), Arg0, )), Local0)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3388:         Store(DerefOf(Index(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg1), )), 0x0, )), Arg0, )), Local0)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3428:             Return(C1C9(0x1, C1B0))
Error    1022 -                      Object does not exist ^  (C1B0)
dsdt.asl-2003-02-09  3431:             C1CA(0x1, C1B0)
Error    1022 -               Object does not exist ^  (C1B0)
dsdt.asl-2003-02-09  3434:             C1CB(0x1, C1B1)
Error    1022 -               Object does not exist ^  (C1B1)
dsdt.asl-2003-02-09  3439:             Return(C1C9(0x2, C1B1))
Error    1022 -                      Object does not exist ^  (C1B1)
dsdt.asl-2003-02-09  3318:         Subtract(C1BA, 0x0aac, Local1)
Error    1022 -          Object does not exist ^  (C1BA)
dsdt.asl-2003-02-09  3321:         Subtract(C1BB, 0x0aac, Local1)
Error    1022 -          Object does not exist ^  (C1BB)
dsdt.asl-2003-02-09  3362:                 Store(Match(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg0), )), 0x1, )), MGT, Local1, MTR, 0x0, 0x0), Local0)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3365:                 Store(Match(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg0), )), 0x0, )), MGT, Local1, MTR, 0x0, 0x0), Local0)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3385:         Store(DerefOf(Index(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg1), )), 0x1, )), Arg0, )), Local0)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3388:         Store(DerefOf(Index(DerefOf(Index(DerefOf(Index(C1AF, C1CD(Arg1), )), 0x0, )), Arg0, )), Local0)
Error    1022 -                                                 Object does not exist ^  (C1AF)
dsdt.asl-2003-02-09  3428:             Return(C1C9(0x1, C1B0))
Error    1022 -                      Object does not exist ^  (C1B0)
dsdt.asl-2003-02-09  3431:             C1CA(0x1, C1B0)
Error    1022 -               Object does not exist ^  (C1B0)
dsdt.asl-2003-02-09  3434:             C1CB(0x1, C1B1)
Error    1022 -               Object does not exist ^  (C1B1)
dsdt.asl-2003-02-09  3439:             Return(C1C9(0x2, C1B1))
Error    1022 -                      Object does not exist ^  (C1B1)
dsdt.asl-2003-02-09  3442:             C1CA(0x2, C1B1)
Error    1022 -               Object does not exist ^  (C1B1)
dsdt.asl-2003-02-09  3445:             C1CB(0x2, C1B2)
Error    1022 -               Object does not exist ^  (C1B2)
dsdt.asl-2003-02-09  3450:             Return(C1C9(0x4, C1B2))
Error    1022 -                      Object does not exist ^  (C1B2)
dsdt.asl-2003-02-09  3453:             C1CA(0x4, C1B2)
Error    1022 -               Object does not exist ^  (C1B2)
dsdt.asl-2003-02-09  3456:             C1CB(0x4, C1B3)
Error    1022 -               Object does not exist ^  (C1B3)
dsdt.asl-2003-02-09  3461:             Return(C1C9(0x8, C1B3))
Error    1022 -                      Object does not exist ^  (C1B3)
dsdt.asl-2003-02-09  3464:             C1CA(0x8, C1B3)
Error    1022 -               Object does not exist ^  (C1B3)

My dsdt.asl is located at:
http://www.scrye.com/~kevin/acpi-2003-02-09/dsdt.asl

Most of those look like thermal handling issues. 
Commenting those problems out or telling iasl to ignore them for now,
I stick my custon dsdt.hex file into the 2.4.21-pre4 kernel and boot
and I get: 

tbget-0273: *** Info: Table [DSDT] replaced by host OS
tbrsdt-0208: *** Error: Invalid signature where RSDP indicates RSDT/XSDT should be located
RSDT/XSDT signature at 2FFF0C84 (2fff0c84) is invalid
tbxface-0085: *** Error: acpi_load_tables: Could not load RSDT: AE_BAD_SIGNATURE
tbxface-0115: *** Error: acpi_load_tables: Could not load tables: AE_BAD_SIGNATURE
Unable to load the System Description Tables

Anyone have any ideas on the problem there?

Back to 2.4.18 for now I guess. 
Any help or pointers would be appreciated. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+RvYE3imCezTjY0ERArt2AJ4vV/Ka8eZp3Hu5rJkEan+Lk6MshACeJz/R
F3IkoiDztOr8GOudpNgW6t0=
=FBk3
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
