From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output for ubuntu - Acer Ferrari 5000
Date: Sat, 19 Jan 2008 00:03:12 -0500
Message-ID: <200801190003.12223.lenb@kernel.org>
References: <937912.50717.qm@web33314.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45783 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbYASFD0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 00:03:26 -0500
In-Reply-To: <937912.50717.qm@web33314.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Barnes <danhbarnes@yahoo.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 01 November 2007 19:09, Dan Barnes wrote:
> Information found in the dmesg output suggested
> sending the dmidecode output to you.
> 
> This is from kernel:
> 
> Linux ubuntu 2.6.22-8-generic #1 SMP Thu Jul 12
> 15:59:45 GMT 2007 i686 GNU/Linux
> 
> If you do not want this info, please let me know.
> 
> Also what problem are you trying to solve?

We're trying to limit Linux exposure to BIOS bugs
by disabling OSI(Linux) by default.  However, to
do so, we need to survey the systems that use it
to see if any actually need it.


Thanks for the dmidecode output.

Do you notice any functional difference when booting with...

"acpi_osi=Linux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=!Linux"       (default for 2.6.23 and later)

...in particular, please check sound and wifi.

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php


System Information
	Manufacturer: Acer, inc.
	Product Name: Ferrari 5000    
	Version: Not Applicable
	Serial Number: LXFR50U059709101362500
	UUID: A02BAF22-2158-D811-8B16-001636A65708
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Acer, Inc.
	Product Name: Ferrari5        
