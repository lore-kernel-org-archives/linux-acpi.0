From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ASL help with latest acpi and compaq presario 2800t
Date: Mon, 10 Feb 2003 13:25:38 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19BAA1@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Ducrot Bruno' <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Kevin Fenzi <kevin-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>>Alas, your DSDT do not contains some of the objects not found.  This is
>>likely because you have SDST tables which contains them.  You need to
>>force the compilation.

Or add ASL "Extern" statements for each symbol that is not found.

I'm thinking about having the disassembler add extern statements
automatically.

Bob

-----Original Message-----
From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] 
Sent: Monday, February 10, 2003 5:58 AM
To: Kevin Fenzi
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] ASL help with latest acpi and compaq presario 2800t

On Sun, Feb 09, 2003 at 05:44:48PM -0700, Kevin Fenzi wrote:
> 
> Greetings. 
> 
> I have been running nicely on my presario 2800t for a while, but with
> kernel 2.4.18 and a pretty old acpi version. 
> 
> So, what better to do on a lazy sunday than try and upgrade to
> 2.4.21-pre4 and the newest acpi? :) 
> 
> I pulled down the 2.4.21-pre4 kernel. Applied the
> acpi-20030125-2.4.21-pre3.diff.gz diff to it. 
> Then applied the patch-acpi-acpi20030125-swsusp18.gz software
> suspend+acpi patch to that. 
> 
> First I tried just compiling that and seeing how acpi would work. 
> It came up, but of course with no battery/ac, etc due to the broken
> compaq dsdt. 
> 
> So, I pulled down acpidump and iasl-linux-20030123.tar.gz
> dumped out the dsdt and tried to compile it. 
> 
> 56 errors. 
> 
> I first fixed all the "String must be entirely alphanumeric" errors
> (compaq seems to like putting * in all their names.)
> I realize it's against the spec, but could something be added to
> change * to nothing if it finds it in a Name? 
> 
> Fixing those got me down to 21 errors. 
> (Worth noting that at this point with the old iasl I was using with
> 2.4.18 there were no further errors here). 
> 
> Any ideas on any of these:
> 
> dsdt.asl-2003-02-09   168:                 If(\_OSI) {
> Error    1028 -                 Too few arguments ^  (\_OSI requires 1)
> dsdt.asl-2003-02-09   169:                     "Windows 2001"
> Error    1037 -                                             ^ parse error,
unexpected PARSEOP_STRING_LITERAL


Try:

--- dsdt.asl	2003/02/10 13:49:25	1.1
+++ dsdt.asl	2003/02/10 13:54:53
@@ -165,8 +165,7 @@
         }
         If(LOr(LEqual(C009, 0x0), LEqual(C009, 0x3))) {
             If(CondRefOf(\_OSI, Local0)) {
-                If(\_OSI) {
-                    "Windows 2001"
+                If(\_OSI("Windows 2001")) {
                     Store(0x4, C009)
                 }
             }
@@ -1916,7 +1915,7 @@
                         }
                         Method(_OFF) {
                             If(LOr(\_SB_.C020, LEqual(0x0, 0x1))) {
-                                Return(0x0)
+                                /* Return(0x0) */
                             }
                             C132(0x3, 0x0)
                         }
@@ -2202,7 +2201,7 @@
                         }
                         Method(_OFF) {
                             If(LOr(\_SB_.C023, LEqual(0x0, 0x1))) {
-                                Return(0x0)
+                                /* Return(0x0) */
                             }
                             C132(0x1, 0x0)
                         }
@@ -2285,7 +2284,7 @@
                 }
             }
             Scope(C162) {
-                Name(_HID, "*SYN0100")
+                Name(_HID, "SYN0100")
                 Name(_CID, Package(0x2) {
                     0x02002e4f,
                     0x130fd041,



Alas, your DSDT do not contains some of the objects not found.  This
is likely because you have SDST tables which contains them.  You need
to force the compilation.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
