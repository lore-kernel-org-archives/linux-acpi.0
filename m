From: Bjorn Helgaas <bjorn_helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [ACPI] RE: [BK PATCH] ACPI updates
Date: Mon, 9 Dec 2002 12:45:07 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200212091245.07770.bjorn_helgaas@hp.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com> <20021209191252.N20336@parcelfarce.linux.theplanet.co.uk> <20021209141720.A11277@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20021209141720.A11277-s/M1imWmeEoQw3kMeb7FcACJwEvxM/w9@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hanno =?iso-8859-1?q?B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, pavel-+ZI9xUNit7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday 09 December 2002 12:17 pm, Arjan van de Ven wrote:
> On Mon, Dec 09, 2002 at 07:12:52PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 09, 2002 at 02:09:04PM -0200, Marcelo Tosatti wrote:
> > > Which machines do not work without the new ACPI code?
> > 
> > hp's zx1-based ia64 machines (my personal interest..) 
> 
> That one doesn't boot without other major patches anyway...

Apart from ACPI, the non-ia64 patches required to boot a zx1
should be relatively small: some IRQ changes, support in
memmap_init for discontiguous memory, etc.

Having a newer ACPI in 2.4.x (it currently has 20011018!)
would make things much easier for ia64.
