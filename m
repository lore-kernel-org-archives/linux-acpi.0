From: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Subject: Re: [Bug #15124] PCI host bridge windows ignored (works with
 pci=use_crs)
Date: Thu, 28 Jan 2010 12:35:07 -0800
Message-ID: <20100128123507.2d6a3b33@jbarnes-piketon>
References: <md-TZL3UUvL.A.FiE.xJMXLB@chimera>
	<4B61D554.9000003@kernel.org>
	<20100128110331.61455a15@jbarnes-piketon>
	<201001282128.33389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201001282128.33389.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jeff Garrett <jeff-184d8XiO+QJg9hUCZPvPmw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Myron Stowe <myron.stowe-VXdhtT5mjnY@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 28 Jan 2010 21:28:33 +0100
"Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> > But disabling it gets us into trouble too.  When platforms are
> > designed for Linux, they may be designed to have ACPI disabled
> > (though this is probably rare for general purpose PCs and servers).
> 
> Well, not quite.  On recent SMP systems it's next to impossible to
> get all of the necessary system configuration information without
> ACPI, since it only is provided by the ACPI tables (the configuration
> of APICs, interrupt routing, CPU C states, other stuff).
> 
> [BTW, I think it's better to CC linux-acpi and Len at this point.]

I was thinking more of custom designed low power servers or something,
possibly running LinuxBIOS or some other custom BIOS.  For a general
purpose machine though I'm 100% agreed.  ACPI is required these days
for PCs.

I was trying to make a point that we shouldn't disable ACPI on
platforms that support it.  Rather, we should fix any bugs we discover
in handling ACPI correctly, rather than working around it by turning it
off.

-- 
Jesse Barnes, Intel Open Source Technology Center
