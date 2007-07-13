From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode
Date: Fri, 13 Jul 2007 15:39:00 -0400
Message-ID: <200707131539.00276.lenb@kernel.org>
References: <835b805b0707120457l72ba2a5cmb5970418d771dabe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49507 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760675AbXGMTkc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jul 2007 15:40:32 -0400
In-Reply-To: <835b805b0707120457l72ba2a5cmb5970418d771dabe@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guillermo Bonvehi <gbonvehi@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 12 July 2007 07:57, Guillermo Bonvehi wrote:
> As requested on dmesg, I hope it helps you.
> Thanks for all the work you're doing.
> 
> # dmidecode 2.9
> SMBIOS 2.4 present.
> 17 structures occupying 649 bytes.
> Table at 0x000E3810.
..
> System Information
> 	Manufacturer: Hewlett-Packard
> 	Product Name: Presario C500 (GB125LA#AC8)
> 	Version: F.24
> 	Serial Number: CND7150Z69
> 	UUID: 03154D10-DE14-11DB-9A51-0016D4E68708
> 	Wake-up Type: Power Switch
> 	SKU Number: GB125LA#AC8
> 	Family: 103C_5335KV
> 
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> 	Manufacturer: Hewlett-Packard
> 	Product Name: 30C6
> 	Version: 78.10
> 	Serial Number: CND7150Z69

Thanks, this is because of the acpi_osi=!Linux message?
Did you try acpi_osi=!Linux and notice any difference?

If you send along the output from acpidump, or better yet,
attach it to a bug report (say this one 
http://bugzilla.kernel.org/show_bug.cgi?id=7787

then i can peek at what HP is doing on this box and get a good idea
if they should be on the white-list or on the blacklist.

thanks,
-Len
