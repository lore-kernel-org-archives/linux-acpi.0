From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [ACPI] Re: Fixing USB interrupt problems with ACPI enabled
Date: Thu, 4 Sep 2003 03:15:09 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309040315.09955.adq_dvb@lidskialf.net>
References: <7F740D512C7C1046AB53446D3720017304AEEC@scsmsx402.sc.intel.com> <20030903153746.A19323@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030903153746.A19323-BI/OLcgY7/cyyg0EjBt7GtHuzzzSOjJt@public.gmane.org>
Content-Disposition: inline
To: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>, "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 03 September 2003 23:37, Chris Wright wrote:
> * Nakajima, Jun (jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) wrote:
> > Doing this for Len, who is on vacation. We would like to thank the
> > people who provided debugging info such as acpidmp, dmidecode, and
> > demsg. This is one of our findings, and we believe this would fix some
> > interrupt problems (with USB, for example) with ACPI enabled, especially
> > when the dmesg reads like:
> >
> > ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
> > ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
> > ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
> > ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0
> >
> > Basically we assumed that _CRS returned the one we set with _SRS, when
> > setting up a PCI interrupt link device, but that's not the case with
> > some AML codes. Some of them always return 0.
> > Attached is a patch against 2.4.23-pre1. It should be easy to apply this
> > to 2.6.

Wow! This is exactly the idea I've just come up with for VIA boards!
