From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] Add lspnp support for sysfs
Date: Thu, 19 Jan 2006 16:50:59 -0700
Message-ID: <200601191650.59642.bjorn.helgaas@hp.com>
References: <200601131051.36906.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:16006 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1161243AbWASXvF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 18:51:05 -0500
In-Reply-To: <200601131051.36906.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Friday 13 January 2006 10:51, Bjorn Helgaas wrote:
> Add lspnp support for sysfs.  This makes it work with generic PNP
> (including PNPACPI, PNPBIOS, ISAPNP) instead of just with PNPBIOS.
> I'm particularly interested in ia64, which never has PNPBIOS, but
> may have PNPACPI.

Any more feedback on this?  I'd like to see lspnp work again
on modern systems, because it's so much easier to tell a user
to run lspnp than it is to tell him how to grub around in
/sys/bus/pnp/devices.
