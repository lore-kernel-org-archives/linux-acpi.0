From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC] Add lspnp support for sysfs
Date: Wed, 1 Feb 2006 08:53:29 -0700
Message-ID: <200602010853.29583.bjorn.helgaas@hp.com>
References: <200601131051.36906.bjorn.helgaas@hp.com> <200601311007.07379.bjorn.helgaas@hp.com> <20060201055911.GA13540@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:39047 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1422646AbWBAPxh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Feb 2006 10:53:37 -0500
In-Reply-To: <20060201055911.GA13540@sonic.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Hinds <dhinds@sonic.net>
Cc: linux-pcmcia@lists.infradead.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

On Tuesday 31 January 2006 22:59, David Hinds wrote:
> I think it would be good for lspnp to live somewhere other than
> pcmcia-cs.  It really doesn't belong there, and now that pcmcia-cs is
> essentially deprecated, it makes even less sense.

I agree with that.  Is anybody interested in maintaining a "pnputils"
package?
