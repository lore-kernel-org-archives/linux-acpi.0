From: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [ACPI] RE: [BK PATCH] ACPI updates
Date: Mon, 9 Dec 2002 14:17:41 -0500
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021209191741.GA26391@gtf.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com> <20021206125943.2199892e.hanno@gmx.de> <20021206072932.B16173@devserv.devel.redhat.com> <20021206131746.C10368@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.50L.0212091408120.10894-100000@freak.distro.conectiva> <20021209191252.N20336@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021209191252.N20336-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>, Arjan van de Ven <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hanno B?ck <hanno-Mmb7MZpHnFY@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, pavel-+ZI9xUNit7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 09, 2002 at 07:12:52PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 09, 2002 at 02:09:04PM -0200, Marcelo Tosatti wrote:
> > Which machines do not work without the new ACPI code?
> 
> hp's zx1-based ia64 machines (my personal interest..) and i thought some
> laptops required updated ACPI to boot.  also, aren't there some SMP x86
> boxes with buggy bios tables that won't boot without ACPI?

There are several classes of machines that require ACPI to boot... a big
question is whether these machines need full ACPI or just acpitable.c,
too...
