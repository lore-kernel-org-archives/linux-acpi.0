From: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 11:38:08 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030903093808.GA28594@k3.hellgate.ch>
References: <20030903080852.GA27649@k3.hellgate.ch> <200309031123.58713.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309031123.58713.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 03 Sep 2003 11:23:58 +0100, Andrew de Quincey wrote:
> Hi, I'm trying to develop patches for ACPI IRQ issues. 

That would be most appreciated.

> Are these VIA KT333/KT400 chipsets? If so, there's a known bug in many BIOSes 

Yes, at least some of them are. I often don't know, since the reports just
say "Rhine ethernet broke in the new kernel" (VIA based boards typically
come with Rhine ethernet integrated into the south bridge).

> with these chipsets. I'm waiting on some docs from VIA to fix this issue.

Which still leaves the question of why it used to work (or made the
impression it did) with older kernels.

Roger
