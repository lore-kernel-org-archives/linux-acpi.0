From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] Add lspnp support for sysfs
Date: Tue, 31 Jan 2006 10:07:07 -0700
Message-ID: <200601311007.07379.bjorn.helgaas@hp.com>
References: <200601131051.36906.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel8.hp.com ([156.153.255.206]:40916 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751259AbWAaRHM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jan 2006 12:07:12 -0500
In-Reply-To: <200601131051.36906.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, David Hinds <dhinds@sonic.net>

On Friday 13 January 2006 10:51, Bjorn Helgaas wrote:
> Add lspnp support for sysfs.  This makes it work with generic PNP
> (including PNPACPI, PNPBIOS, ISAPNP) instead of just with PNPBIOS.
> I'm particularly interested in ia64, which never has PNPBIOS, but
> may have PNPACPI.

Ping.  I think we have two votes in favor of this, at least in
concept (mine and Adam's).  We had a couple tangential questions.
Nobody seemed really opposed.

What can I do to either advance this or come to the conclusion
that it's not worth the effort?  David, are you the pcmcia-cs
maintainer?  Are you interested in this at all?

Bjorn
