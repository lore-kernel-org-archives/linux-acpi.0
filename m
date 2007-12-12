From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [ACPICA] EmbeddedControl region handling bug in PNP0C14
Date: Wed, 12 Dec 2007 21:13:35 +0300
Message-ID: <476024CF.3000800@gmail.com>
References: <200711280350.08539.carlos@strangeworlds.co.uk> <200712121410.15587.carlos@strangeworlds.co.uk> <476001E4.9020900@gmail.com> <200712121726.53180.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080307070909050106040009"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:32243 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbXLLSMx (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 12 Dec 2007 13:12:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so646221ugc.16
        for <Linux-acpi@vger.kernel.org>; Wed, 12 Dec 2007 10:12:49 -0800 (PST)
In-Reply-To: <200712121726.53180.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: "Moore, Robert" <robert.moore@intel.com>, Linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

This is a multi-part message in MIME format.
--------------080307070909050106040009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Carlos Corbacho wrote:
> Alexey,
>
> Is the code in EC0 interfering then with the EC access code in AMW0? (See 
> lines 962 onwards for the AMW0 EmbeddedControl region bits)?
>
> Because AFAICT, the EC0 code is fine (my 5020 has the same AML for EC0 and 
> doesn't have any problem, and the user didn't report any other EC problems - 
> we only see this problem when we try to use the EmbeddedControl region in 
> AMW0).
>
> -Carlos
>
>   
Please check if making AMW0' RAM an alias to EC0 one helps... See 
attachment.

--------------080307070909050106040009
Content-Type: text/x-patch;
 name="a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a.diff"

--- 5040.dsl	2007-12-12 21:03:04.000000000 +0300
+++ 5040a.dsl	2007-12-12 21:02:54.000000000 +0300
@@ -721,7 +721,7 @@
 
         Device (AMW0)
         {
-            Name (_HID, "*pnp0c14")
+            Name (_HID, "PNP0C14")
             Name (_UID, 0x00)
             Name (WLMP, 0x00)
             Name (B0ED, Buffer (0x04)
@@ -959,7 +959,8 @@
             CreateDWordField (CBE0, 0x00, BER4)
             CreateWordField (CBE0, 0x00, BUF0)
             CreateWordField (CBE0, 0x02, BER2)
-            OperationRegion (RAM, EmbeddedControl, 0x00, 0xFF)
+//            OperationRegion (RAM, EmbeddedControl, 0x00, 0xFF)
+            Alias(\_SB.PCI0.LPC0.EC0.RAM, RAM)
             Field (RAM, ByteAcc, Lock, Preserve)
             {
                 CMD0,   8, 
@@ -3614,7 +3615,7 @@
                     }
 
                     OperationRegion (RAM, EmbeddedControl, 0x00, 0xFF)
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0x0A), 
                             ,   1, 
@@ -3637,7 +3638,7 @@
                         BL2W,   1
                     }
 
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0x01), 
                         TIID,   8, 
@@ -3664,19 +3665,19 @@
                         THS7,   8
                     }
 
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0x92), 
                         KTAF,   8
                     }
 
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0x92), 
                         THSL,   4
                     }
 
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0xD0), 
                         TSP0,   8, 
@@ -3985,7 +3986,7 @@
                         Notify (\_TZ.TZS1, 0x80)
                     }
 
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0x02), 
                         NBID,   8, 
@@ -3997,14 +3998,14 @@
                         NB1A,   1
                     }
 
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0x88), 
                         NB0S,   8, 
                         NB1S,   8
                     }
 
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0xE0), 
                         BSRC,   16, 
@@ -4018,7 +4019,7 @@
                         BSBS,   8
                     }
 
-                    Field (RAM, AnyAcc, Lock, Preserve)
+                    Field (RAM, ByteAcc, Lock, Preserve)
                     {
                                 Offset (0xE0), 
                         BSDC,   16, 

--------------080307070909050106040009--
