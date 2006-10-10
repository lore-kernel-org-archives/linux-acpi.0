From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: HP Compaq nc6320 SSDT
Date: Tue, 10 Oct 2006 21:51:50 +0100
Message-ID: <1160513510.8655.12.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:20146 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030349AbWJJUv5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 16:51:57 -0400
Received: from acce212d.ipt.aol.com ([172.206.33.45]:55040 helo=[192.168.1.79])
	by ppsw-3.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.153]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:RC4-MD5:128)
	id 1GXOZq-00063K-Bv (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Tue, 10 Oct 2006 21:51:50 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Just for larks, I decided to iasl -d my SSDT, and found the following
horridness:

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060608 [Jun 29 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

ssdt.orig.dsl   117:                 Store (C0E0, 0x00)
Error    4094 -                                      ^ syntax error,
unexpected PARSEOP_INTEGER

ssdt.orig.dsl   119:                 If (And (C33D, 0x01))
Error    4094 -             syntax error, unexpected ')' ^ 

ssdt.orig.dsl   123:                 Else
Error    4094 -                         ^ syntax error, unexpected
PARSEOP_ELSE

ssdt.orig.dsl   137:                     Store (C0DD (0x00, 0x01), C34C)
Error    4062 -                                 Object does not exist ^
(C34C)

ssdt.orig.dsl   138:                     If (And (C33D, 0x04))
Error    4062 -                Object does not exist ^  (C33D)

ssdt.orig.dsl   140:                         Store (C0DF (0x00, 0x01),
C34D)
Error    4062 -                                     Object does not
exist ^  (C34D)

ssdt.orig.dsl   144:                         Store (C34C, C34D)
Error    4062 -                  Object does not exist ^  (C34C)

ssdt.orig.dsl   144:                         Store (C34C, C34D)
Error    4062 -                        Object does not exist ^  (C34D)

ssdt.orig.dsl   148:                 Return
Error    4094 -                           ^ syntax error, unexpected
PARSEOP_RETURN, expecting $end

ASL Input:  ssdt.orig.dsl - 149 lines, 4718 bytes, 72 keywords
Compilation complete. 9 Errors, 0 Warnings, 0 Remarks, 7 Optimizations

To make it compile nicely, I looked at the DSDT and fixed up the
external method calls (Much of the typing in the External definitions
was wrong), checked the number of arguments, and noted the missing
parenthesis around the arguments which should have been passed to these
calls. (Possibly a decompile bug due to the erronous External()
definitions?)

Diff is:

--- ssdt.orig.dsl       2006-10-10 21:46:26.000000000 +0100
+++ ssdt.dsl    2006-10-10 21:38:55.000000000 +0100
@@ -2,7 +2,7 @@
  * Intel ACPI Component Architecture
  * AML Disassembler version 20060608
  *
- * Disassembly of ssdt.orig.aml, Tue Oct 10 21:46:26 2006
+ * Disassembly of ssdt.asl, Tue Oct 10 16:21:27 2006
  *
  *
  * Original Table Header:
@@ -15,19 +15,19 @@
  *     Creator ID       "MSFT"
  *     Creator Revision 0x0100000E (16777230)
  */
-DefinitionBlock ("ssdt.orig.aml", "SSDT", 1, "HP    ", "HPQSAT",
0x00000001)
+DefinitionBlock ("ssdt.aml", "SSDT", 1, "HP    ", "HPQSAT", 0x00000001)
 {
     External (C0E5, MethodObj)    // 6 Arguments
     External (C0E1, MethodObj)    // 5 Arguments
-    External (C236)
+    External (C236, BuffObj)
     External (C0DF, MethodObj)    // 2 Arguments
-    External (C0E0, IntObj)
+    External (C0E0, MethodObj)    // 1 Arguments
     External (C0DD, MethodObj)    // 2 Arguments
-    External (C239, IntObj)
-    External (C238)
-    External (\_SB_.C240, IntObj)
+    External (C239, BuffObj)
+    External (C238, IntObj)
+    External (\_SB_.C240, MethodObj)    // 2 Arguments
     External (\_SB_.C23A, MethodObj)    // 4 Arguments
-    External (\_SB_.C143)
+    External (\_SB_.C143, MethodObj)    // 0 Arguments
     External (\_SB_.C002, DeviceObj)
     External (\_SB_.C002.C0D5, DeviceObj)
 
@@ -114,8 +114,7 @@
                 CreateDWordField (Local0, 0x0C, C34D)
                 CreateDWordField (Local0, 0x10, C33D)
                 Store (C0DD (0x00, 0x00), C33B)
-                Store (C0E0, 0x00)
-                C33D
+                Store (C0E0 (0x00), C33D )
                 If (And (C33D, 0x01))
                 {
                     Store (C0DF (0x00, 0x00), C33C)
@@ -174,11 +173,7 @@
                         }
 
                         Store (C0E1 (0x00, 0x00, C33B, C33D, Local1),
Local2)
-                        Store (C0E5 (0x00, 0x00, C33C, C33D, Local1,
Local3), \_SB.C23A)
-                        Local2
-                        Local3
-                        Local1
-                        C33A
+                        Store (C0E5 (0x00, 0x00, C33C, C33D, Local1,
Local3), \_SB.C23A (Local2, Local3, Local1, C33A ))
                     }
                 }
             }
@@ -188,9 +183,7 @@
                 Name (_ADR, 0x00)
                 Method (_GTF, 0, NotSerialized)
                 {
-                    Return (\_SB.C240)
-                    C33A
-                    0x00
+                    Return (\_SB.C240 (C33A, 0x00))
                 }
             }
         }



Does this fix seem reasonable to anyone.. how can I override the SSDT in
linux (I've got the DSDT over-ridden, no problem).

Clearly to verify this properly, I need to post the DSDT and SSDT in
their entirety, please let me know if I should post them to this list,
or privately email me and I'll send them.

Are these problems "real", or are they simply the symptom of decompiling
the SSDT in the absence of context from the DSDT?

Regards

Peter Clifton


