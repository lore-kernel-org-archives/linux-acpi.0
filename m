From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 11:48:03 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <200309031148.03941.adq_dvb@lidskialf.net>
References: <20030903080852.GA27649@k3.hellgate.ch> <200309031123.58713.adq_dvb@lidskialf.net> <20030903093808.GA28594@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030903093808.GA28594-NW/W/tFpkLjPJA67Yv3YjA@public.gmane.org>
Content-Disposition: inline
To: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > with these chipsets. I'm waiting on some docs from VIA to fix this issue.
>
> Which still leaves the question of why it used to work (or made the
> impression it did) with older kernels.

I think on earlier kernels there was a bug in ACPI which prevented it from 
being used for PCI IRQ routing. I know this was fixed somewhere in the 2.5.5X 
series.

When this bug was fixed, it unfortunately caused my nforce2 board to stop 
working because of other IRQ issues, which is how I got into this. Its likely 
the same thing causes older kernels to work with Via motherboards to work 
'cos ACPI isn't being used for IRQ routing.

2.4.22 has the ACPI from 2.6 backported into it, (which includes my patch for 
nforce2 boards) so it will start having the same issue with the BIOS bug in 
KT333/KT400  boards.
