From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [ACPI] RE: [BK PATCH] ACPI updates
Date: 06 Dec 2002 15:06:13 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1039187173.23271.10.camel@irongate.swansea.linux.org.uk>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com>
	<20021206125943.2199892e.hanno@gmx.de>
	<20021206072932.B16173@devserv.devel.redhat.com>
	<20021206131746.C10368@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20021206131746.C10368-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, pavel-+ZI9xUNit7I@public.gmane.org, Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-12-06 at 13:17, Matthew Wilcox wrote:
> > the 2.4 patch doesnt' actually offer suspend/resume capabilities; what
> > else did you have in mind as required ?
> 
> booting?

New compaqs, existing xmeta, new HP wont boot without the -ac IDE and
the workarounds for ATi or fixes for ALi IDE. (Users should try to avoid
the ati igp stuff for now btw - no X support, no pci routing support,
most kernels wont run on it, no docs)

Alan
