From: glen martin <lists@locutory.org>
Subject: FIXED: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 18:47:19 -0800
Message-ID: <442B46B7.2040407@locutory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m198-163.dsl.rawbw.com ([198.144.198.163]:758 "EHLO
	slowpoke.locutory.org") by vger.kernel.org with ESMTP
	id S1751458AbWC3CrU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Mar 2006 21:47:20 -0500
Received: from [127.0.0.1] (slowpoke.locutory.org [192.168.0.126])
	by slowpoke.locutory.org (Postfix) with ESMTP id 017081C067
	for <linux-acpi@vger.kernel.org>; Wed, 29 Mar 2006 18:47:18 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Or at least, I'm past my pain, thanks to a lot of help from Robert and Len.

To recap:

The DSDT in my BIOS was very broken, such that ACPI didn't load up 
properly.  This meant I was having trouble reading the data from my BIOS 
using /proc/acpi/dsdt.

To fix this, I applied this patch to the kernel (which was 2.6.15):
   https://bugzilla.novell.com/show_bug.cgi?id=147621#c22
Rebuild, reboot, and I could get at the dsdt data at /proc/acpi/dsdt.

Then iasl couldn't handle the extracted data, because it failed error 
checking in the same way the kernel had. Patch it like this:
<snip>
--- namespace/nssearch.c.~1~    2006-03-29 18:22:16.000000000 -0800
+++ namespace/nssearch.c        2006-03-29 12:11:22.000000000 -0800
@@ -403,7 +403,7 @@
     {
         ACPI_ERROR ((AE_INFO, "Bad character in ACPI Name: %X",
             TargetName));
-        return_ACPI_STATUS (AE_BAD_CHARACTER);
+//        return_ACPI_STATUS (AE_BAD_CHARACTER);
     }

     /* Try to find the name in the namespace level specified by the 
caller */
</p>

This allowed iasl to function on the extracted dsdt data.

There remained some errors in the extracted dsdt that I'm still looking at.

In a side conversation, though, I had another look at a supposedly 
working cleaned-up version of the DSDT for my machine that I downloaded 
from http://acpi.sourceforge.net/dsdt/view.php.  I'd tried to assemble 
it using iasl on Linux, which segfaulted on this file. This was why I 
started down this path of extracting my existing DSDT. But Robert had 
the idea to try it using the Windows binary iasl, and it assembled fine 
there.  I was able to take that binary and load it into my kernel using 
the initramfs dsdt patch here:
   http://gaugusch.at/kernel.shtml.

I wasn't already using an initramfs, so not knowing how, on a lark I 
constructed a bogus one:
  mkdir temp
  cp /path/to/my_dsdt.asl temp/DSDT.asl    // this filename matters
  cd temp
  find . | cpio --quiet -o -H newc | gzip -9 > ../minirt.gz
  cd ..
  rm -r temp
This initramfs is likely bogus, but it worked anyway for this purpose. 
Just add it to your grub.conf in an initrd line.

The reward? Now my onboad LAN interface is working, so I can retire the 
add-on board I installed to get by with. Not that geeks like me need a 
reward.

Hope this recap helps someone. And thanks once again to Robert and Len 
for their help.

glen
