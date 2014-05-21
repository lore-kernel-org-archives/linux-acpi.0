From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V6 09/11] ACPI: introduce flag .is_master_device
Date: Wed, 21 May 2014 22:43:07 +0800
Message-ID: <1400683387.13930.26.camel@rzhang1-toshiba>
References: <1400136256-2218-1-git-send-email-rui.zhang@intel.com>
	 <1400136256-2218-10-git-send-email-rui.zhang@intel.com>
	 <20140521085207.GR1651@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14757 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbaEUOnM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 10:43:12 -0400
In-Reply-To: <20140521085207.GR1651@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com

On =E4=B8=89, 2014-05-21 at 11:52 +0300, Mika Westerberg wrote:
> On Thu, May 15, 2014 at 02:44:14PM +0800, Zhang Rui wrote:
> > For some ACPI device objects, they represent master devices,
> > and their children devices are enumerated by bus controller drivers
> > for the buses they are on.
> >=20
> > In this case, we do not want to enumerate their children devices to
> > platform bus explicitly in acpi scan code.
> >=20
> > Thus a new flag .is_master_device is introduced in this patch.
> >=20
> > For devices with this flag set, we will not do default enumeration
> > for their children.
>=20
> Is there any particular reason we would like to enumerate everything
> below the first device by default?

we do not enumerate everything below the first device by default, we
just enumerate all the devices with _HID.
But if a device has _HID and it is enumerated by its parents to a
separate bus, we need this flag set for its parent.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
