From: paulngen <paulngen@internode.on.net>
Subject: Please send DMI info if system does not work as expected boot with
 acpi=copy=dsdt
Date: Wed, 16 Jun 2010 20:05:18 +1000
Message-ID: <4C18A1DE.7040601@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:64601 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751902Ab0FPKKX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jun 2010 06:10:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I think I may have another satellite model to add to your list of 
toshiba machines that has dsdt problems when linux is run.

I have the following machine:

sys_vendor: TOSHIBA
product_name: Satellite C650D
bios_vendor: Insyde Corp.
bios_version: 1.10
bios_date: 4/14/2010
processor: AMD V120

This machine cannot boot with Ubuntu release 10.04 (Kernel 
2.6.32-22-generic) out of the box.  It will only boot with acpi=off.

When I boot from CD with an in development version of Ubuntu release 
10.10 (think it was from 14 June 2010) which contains version 
2.6.35-2-generic of the kernel I can only boot my machine if I set 
acpi=off or if I set acpi=copy_dsdt.  When I set acpi=copy_dsdt the acpi 
functionality seems to be available (e.g. System>Preferences>Power 
Management application now has 'On battery power' functionality 
working).  Also, my machine can power down without having to physically 
turn it off by pressing the off switch, when acpi=copy_dstd.

So basically the 91236 patch seems to be doing the trick for my computer 
when I set acpi=copy_dsdt.

I have a friend with an ACER Aspire laptop and both versions of ubuntu I 
have tested on my machine (10.04 (with kernel 2.6.32-22-generic) and a 
dev version of 10.10 (with a dev version of kernel 2.6.35-2-generic)), 
work on his machine out of the box with no fiddling with any settings at 
all.

I am sending this email because of what I read in 
https://patchwork.kernel.org/patch/91236/
It is not because of the warning message coded

ACPI_ERROR((AE_INFO,
+			    "The DSDT has been corrupted or replaced - old, new headers below"));


I never see this message when I boot unsuccessfully.  My screen comes up 
with a long list of errors, many with ACPI_ in them but it never 
displays the "DSDT has been corrupted or replaced....." message.  Either 
that or it does display it but then gets swamped by following messages.  
Whatever the case is, I never see it on my screen.

If you need any further information feel free to contact me.  I am not 
that au fait with Unix but will try and help if you need more information.

Regards,
Paul Neale



