From: adelorbeau-GANU6spQydw@public.gmane.org
Subject: Battery error with toshiba 2435
Date: Mon, 15 Dec 2003 09:35:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1071477302.3fdd723612b58@imp4-l.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

Here is some infos about the error I have (I hope it will be usefull):

### System tested: ###

Notebook Toshiba Satellite 2435 - Phoenix BIOS V1.30

Kernel 2.6-test11 + acpi-20031203 + Patch from Yu, Luming (bugzilla[id=1618])
AND
Kernel 2.4.23 + acpi-20031002 ... (I do not use acpi-20031203 with 2.4 because 
the path from Yu, Luming is only for 2.6)

FYI: Using acpi-20031203 without the patch from Yu, Luming create the 2 
following problems:
   A) cat /proc/acpi/battery/BAT1/state
	present:                 yes
	ERROR: Unable to read battery status
   B) dmesg report a *lot* of messages like:
    ACPI-0279: *** Error: Looking up [PBST] in namespace, AE_ALREADY_EXISTS
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BST] 
(Node c15bd200), AE_ALREADY_EXISTS


### What is wrong: ### (With both 2.6 up to date and 2.4 with older acpi)
Command "acpi -ab" output:
     Battery 1: discharging, 98%, charging at zero rate - will never fully 
charge.
  AC Adapter 1: off-line

"cat /proc/acpi/battery/BAT1/state"
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            0 mA		***** BAD Value *****
remaining capacity:      3920 mAh
present voltage:         16223 mV

DMESG:
With 2.4 and acpi-20031002:
    ACPI-0277: *** Error: Looking up [PBST] in namespace, AE_ALREADY_EXISTS
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BST] 
(Node c15bd200), AE_ALREADY_EXISTS
And some times I can see the following too:
    ACPI-0345: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1120: *** Error: Method execution failed [\_SB_.PCI0.LPC0.BAT1._BST] 
(Node c15b51c0), AE_TIME


### DSDT: ###
I have writen the following patch using some samples found on the net,
but I am not sure of my corrections even if iasl repport now 0 errors,
0 warnings and 0 remarks.

*** But anyway, loading the corrected dsdt do not change anything. ***


Here is the patch I did (Without knowing ASL at all, so ...):

--- dsdt_orig.dsl       2003-11-15 22:26:59.000000000 -0600
+++ dsdt.dsl    2003-11-15 22:37:57.000000000 -0600
@@ -108,6 +108,7 @@
             Notify (\_SB.PCI0.IDEC.SECD, 0x00)
             Notify (\_SB.PCI0.IDEC.SECD.S_D0, 0x01)
         }
+    Return(Package(0x02){0x00, 0x00})
     }

     Method (MIN, 2, NotSerialized)
@@ -262,7 +263,7 @@
             }

             OperationRegion (ECR, EmbeddedControl, 0x00, 0xFF)
-            Field (ECR, AnyAcc, Lock, Preserve)
+            Field (ECR, ByteAcc, Lock, Preserve)
             {
                 Offset (0x9E),
                     ,   4,
@@ -3656,7 +3657,7 @@
                     }

                     OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
-                    Field (ERAM, AnyAcc, Lock, Preserve)
+                    Field (ERAM, ByteAcc, Lock, Preserve)
                     {
                         Offset (0x60),
                         SMPR,   8,
@@ -3998,7 +3999,7 @@
                     }

                     OperationRegion (ECRM, EmbeddedControl, 0x00, 0xFF)
-                    Field (ECRM, AnyAcc, Lock, Preserve)
+                    Field (ECRM, ByteAcc, Lock, Preserve)
                     {
                         Offset (0x94),
                         ERIB,   16,


Thanks in advance for the help and informations you could provide; If you need 
more information about my system like the original dsdt etc, just ask.

Arnaud de Lorbeau.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
