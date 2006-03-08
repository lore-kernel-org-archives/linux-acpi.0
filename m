From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: RE: Re is there an easy way to tell if anacpi_deviceis on a PCI bus?
Date: Wed, 8 Mar 2006 13:29:03 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0603081326340.10491@shark.he.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30065236FA@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:13034 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932521AbWCHV3E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Mar 2006 16:29:04 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 13:29:03 -0800
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30065236FA@hdsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Accardi, Kristen C" <kristen.c.accardi@intel.com>, linux-acpi@vger.kernel.org

On Wed, 8 Mar 2006, Brown, Len wrote:

>
> >To find if an acpi_device is a child of a PCI bus, it seems
> >that you need to look at its parent, and parents of parents...
> >to see if any are a PCI bus, eg have HID PNP0A03.
>
> Alternatively, you could go top-down,
> acpi_get_devices( PCI_ROOT_HID_STRING,
> 	and provide a callback to walk below the PCI bus found
> 	to see if you find your device.

I think that's what the SATA-ACPI patch does to find SATA objects,
if you want to look and see if if would help you at all.
Check http://www.xenotime.net/linux/SATA/2.6.16-rc4/libata-acpi.patch,
the callback function is get_devices().

-- 
~Randy
