From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Date: Mon, 23 Jun 2003 23:23:11 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030623222311.GD25982@parcelfarce.linux.theplanet.co.uk>
References: <20030623221541.GA8096@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030623221541.GA8096-doiv7TgLjtAqfaPKo25k7GZHpeb/A1Y/@public.gmane.org>
To: Marek Michalkiewicz <marekm-HuSaFJn/uQtscumT1wHf3A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 24, 2003 at 12:15:41AM +0200, Marek Michalkiewicz wrote:
> long time ago I noticed a problem with the ACPI IRQ not working
> if it is _not_ shared with some other PCI IRQ.  The problem still
> exists in the 2.4.21 kernel, confirmed on two machines with the
> MSI MS-6368L motherboard (VIA PLE133 chipset).

Have you patched 2.4.21 with the latest ACPI patch, or is this vanilla
2.4.21?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
