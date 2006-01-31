From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [RFC] Add lspnp support for sysfs
Date: Tue, 31 Jan 2006 18:46:25 +0100
Message-ID: <43DFA271.4030504@free.fr>
References: <200601131051.36906.bjorn.helgaas@hp.com> <200601311007.07379.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:11737 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1751305AbWAaRos (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jan 2006 12:44:48 -0500
In-Reply-To: <200601311007.07379.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pcmcia@lists.infradead.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Li Shaohua <shaohua.li@intel.com>, David Hinds <dhinds@sonic.net>

Hi everybody,

Bjorn Helgaas wrote:
> On Friday 13 January 2006 10:51, Bjorn Helgaas wrote:
> 
>>Add lspnp support for sysfs.  This makes it work with generic PNP
>>(including PNPACPI, PNPBIOS, ISAPNP) instead of just with PNPBIOS.
>>I'm particularly interested in ia64, which never has PNPBIOS, but
>>may have PNPACPI.
> 
> 
> Ping.  I think we have two votes in favor of this, at least in
> concept (mine and Adam's).  We had a couple tangential questions.
> Nobody seemed really opposed.
I also think it is a good idea.

Matthieu
