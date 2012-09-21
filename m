From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH V2] ACPI: Allow acpi binding with usb3.0 hub
Date: Fri, 21 Sep 2012 11:16:01 +0800
Message-ID: <505BDBF1.2020209@intel.com>
References: <1345185849-3041-1-git-send-email-tianyu.lan@intel.com> <20120921002527.GB6909@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42136 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab2IUDRn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Sep 2012 23:17:43 -0400
In-Reply-To: <20120921002527.GB6909@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On 2012=E5=B9=B409=E6=9C=8821=E6=97=A5 08:25, Sarah Sharp wrote:
> Hi Tianyu,
>=20
> You're correct that the USB core and the xHCI driver has a slightly
> different architecture than the ACPI representation.  We have one PCI
> device that has two USB buses/roothubs underneath it.  That's because
> external USB 3.0 hubs show up as two USB devices: a USB 3.0 only
> portion, and a USB 2.0 portion.  We wanted roothubs to act the same w=
ay.
>=20
> The architecture looks something like this:
>=20
>       struct pci_dev
>       |
> struct usb_hcd *primary_hcd -- struct usb_hcd *secondary_hcd
>       |                               |
> struct usb_bus                  struct usb_bus
>       |                               |
>  struct usb_device *root_hub     struct usb_device *root_hub
>       |                               |
>    struct device                   struct device
>=20
> Where the primary_hcd is for the USB 2.0 roothub, and the secondary_h=
cd
> is for the USB 3.0 roothub.
>=20
> So you're trying to bind one ACPI node (RHUB) to the struct device
> contained in those two root_hubs, correct?  That goal seems sane to m=
e.
>=20
Yes, that is my patch's purpose.

> Sarah Sharp


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
