From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: RE: Re is there an easy way to tell if anacpi_deviceis on a PCI bus?
Date: Wed, 8 Mar 2006 14:27:41 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0603081420370.10491@shark.he.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B300652388B@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:3285 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030231AbWCHW1m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 17:27:42 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 14:27:41 -0800
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300652388B@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org

On Wed, 8 Mar 2006, Brown, Len wrote:

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
> >Check http://www.xenotime.net/linux/SATA/2.6.16-rc4/libata-acpi.patch,
> >the callback function is get_devices().
>
> + status = acpi_get_devices(NULL, get_devices, winfo, NULL);
>
> Looks like you're calling get_devices()
> for every device in the tree?  No HID for SATA devices?

Not that I ever found.

> Randy,
> looks like you're building full pathnames for every device in the tree.
> can you decode for me what you're using the full ACPI pathnames for?
> I see debug printout, which I expect, but it seems that you're
> saving them and string-comparing them also, which strikes me
> as sort of odd.

I'm all for finding better discovery methods, but it's isolated enough
(in this code) to be easily replaced, I think.  I'm more interested in making
it work first.

This code uses full path names to map a PCI dev.func to a SATA device number and
then to ACPI objects.
Once it has an ACPI object, it can evaluate the ACPI methods, of course,
but getting to the ACPI object when only given a SATA device number
seemed troubling.  Maybe I went the long way around and it is worth
reconsidering how it should be done, independently of the rest of the code.

I can go into more detail on this later today if you want me to.


> Re: debug printouts
> We should come up with a best-known way to get and print
> full pathnames, b/c they're done in several ways in
> several places....

Good idea.

-- 
~Randy
