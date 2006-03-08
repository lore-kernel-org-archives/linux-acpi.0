From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Re is there an easy way to tell if anacpi_deviceis on a PCI bus?
Date: Wed, 8 Mar 2006 14:20:36 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E0499CDE0@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:35210 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932513AbWCHWUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 17:20:41 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Accardi, Kristen C" <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org

> Re: debug printouts
> We should come up with a best-known way to get and print
> full pathnames, b/c they're done in several ways in
> several places....

The AcpiGetName interface will take a namespace node and return a full
pathname, it should be used whenever this is needed.

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Brown, Len
> Sent: Wednesday, March 08, 2006 2:13 PM
> To: Randy.Dunlap
> Cc: Accardi, Kristen C; linux-acpi@vger.kernel.org
> Subject: RE: Re is there an easy way to tell if anacpi_deviceis on a
PCI
> bus?
> 
> 
> >> >To find if an acpi_device is a child of a PCI bus, it seems
> >> >that you need to look at its parent, and parents of parents...
> >> >to see if any are a PCI bus, eg have HID PNP0A03.
> >>
> >> Alternatively, you could go top-down,
> >> acpi_get_devices( PCI_ROOT_HID_STRING,
> >> 	and provide a callback to walk below the PCI bus found
> >> 	to see if you find your device.
> >
> >I think that's what the SATA-ACPI patch does to find SATA objects,
> >if you want to look and see if if would help you at all.
> >Check
http://www.xenotime.net/linux/SATA/2.6.16-rc4/libata-acpi.patch,
> >the callback function is get_devices().
> 
> + status = acpi_get_devices(NULL, get_devices, winfo, NULL);
> 
> Looks like you're calling get_devices()
> for every device in the tree?  No HID for SATA devices?
> 
> Randy,
> looks like you're building full pathnames for every device in the
tree.
> can you decode for me what you're using the full ACPI pathnames for?
> I see debug printout, which I expect, but it seems that you're
> saving them and string-comparing them also, which strikes me
> as sort of odd.
> 
> Re: debug printouts
> We should come up with a best-known way to get and print
> full pathnames, b/c they're done in several ways in
> several places....
> 
> thanks,
> -Len
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
