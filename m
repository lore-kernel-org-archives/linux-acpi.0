From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Acer TM3012
Date: Sun, 20 Jan 2008 18:27:12 -0500
Message-ID: <200801201827.12708.lenb@kernel.org>
References: <20080119132321.GC3262@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54345 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756072AbYATX1b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 18:27:31 -0500
In-Reply-To: <20080119132321.GC3262@gamma.logic.tuwien.ac.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org

On Saturday 19 January 2008 08:23, Norbert Preining wrote:
> Hi all, 
> 
> the kernel asks me to send the dmidecode to the list. I always forgot
> that, but after seeing Len's activitly I decided it might actually be of
> interest.
> 
> Hardware: Acer TravelMate 3012
> Kernel: 2.6.24-rc8
> kernel cmd line: root=/dev/sda3 ro usbcore.autosuspend=1 resume=/dev/sda2
> OS: Debian/sid
> 
> I am quite content having s2r and s2d normally running (save some
> regression I haven't checked/found). Only one thing puzzled me namely
> that the computer was in s2r sleep and used all the battery within
> 12hours.

hmmm, probably we're not disabling some device before we suspend.
i wonder how long windows lasts in s2r on the same box...

> Ok, here it is
> 
> # dmidecode 2.9
> SMBIOS 2.4 present.
> 34 structures occupying 1079 bytes.
> Table at 0x000DF810.
> 
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
> 	Vendor: Acer   
> 	Version: v1.3125
> 	Release Date: 08/14/06
> 	Address: 0xE6720
> 	Runtime Size: 104672 bytes
> 	ROM Size: 512 kB
> 	Characteristics:
...
> 
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
> 	Manufacturer: Acer, inc.
> 	Product Name: TravelMate 3010 
> 	Version: Not Applicable
> 	Serial Number: LXTAT0602260908070EM02
> 	UUID: C07A79BF-CB90-D811-97A0-0016361E27AD
> 	Wake-up Type: Power Switch
> 	SKU Number: Not Specified
> 	Family: Not Specified
> 
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> 	Manufacturer: Acer, Inc.
> 	Product Name: Ness            
> 	Version: Not Applicable
> 	Serial Number: LXTAT0602260908070EM02

thanks for the dmidecode (DMI entry added)
can you send me the acpidump so I can figure out how to set the DMI entry?

thanks,
-Len
