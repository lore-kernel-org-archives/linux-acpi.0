From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
Date: Sun, 7 Sep 2003 15:54:57 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309071554.57500.adq_dvb@lidskialf.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060157.47121.adq_dvb@lidskialf.net> <1062863230.2795.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1062863230.2795.1.camel-Z+iYsftfazAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Content-Disposition: inline
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 06 September 2003 16:47, Alan Cox wrote:
> On Sad, 2003-09-06 at 01:57, Andrew de Quincey wrote:
> > This patch removes some erroneous code from mpparse which breaks IO-APIC
> > programming
>
> These shouldnt be removed but checked against the arch being an E7000,
> which does need this.

Should that code be added back into 2.4.23-pre3? 
