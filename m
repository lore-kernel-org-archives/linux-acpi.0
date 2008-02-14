From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode.log - ThinkPad R61
Date: Wed, 13 Feb 2008 22:39:15 -0500
Message-ID: <200802132239.15346.lenb@kernel.org>
References: <1672249795@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46648 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031AbYBNDj3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 22:39:29 -0500
In-Reply-To: <1672249795@web.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Copperworm@web.de
Cc: linux-acpi@vger.kernel.org


> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
> 	Vendor: LENOVO
> 	Version: 7KETA9WW (2.09 )
> 	Release Date: 12/27/2007
> 	Address: 0xE0000
> 	Runtime Size: 128 kB
> 	ROM Size: 2048 kB
...
> 	BIOS Revision: 2.9
> 	Firmware Revision: 1.8
> 
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
> 	Manufacturer: LENOVO
> 	Product Name: 89196VG
> 	Version: ThinkPad R61

The R61 is already on our latest (white)list,
so you should not longer be prompted for dmidecode running
the latest 2.6.23.stable, 2.6.24.stable, or 2.6.25.

(I'll be sending a patch to 2.6.22.stable to remove the request there soon)

thanks,
-Len

> 	Serial Number: L3B2694
> 	UUID: -
> 	Wake-up Type: Power Switch
> 	SKU Number: Not Specified
> 	Family: ThinkPad R61
> 
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> 	Manufacturer: LENOVO
> 	Product Name: 89196VG
> 	Version: Not Available
> 	Serial Number: -
