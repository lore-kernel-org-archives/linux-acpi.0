From: Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Fri, 5 Sep 2003 17:02:24 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030905170224.A16217@osdlab.pdx.osdl.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F59018E.5060604@pobox.com> <200309060016.16545.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200309060016.16545.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>; from adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org on Sat, Sep 06, 2003 at 12:16:15AM +0100
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

* Andrew de Quincey (adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org) wrote:
> On Friday 05 Sep 2003 10:35 pm, Jeff Garzik wrote:
> > This is why we _really_ need you to split up your patches.  Multiple
> > split-up patches, one per email, is preferred.  Don't worry about
> > sending us too much email:  we like it like that.
> 
> If/when I split it up, is it acceptable to number the patches to give the 
> order they have to be applied in? The major problem with these particular 
> fixes is that they all run over the same set of files, even the same 
> functions, so they all conflict with each other. 

Yes, please split them up.
                                                                                
I finally narrowed down to the ChangeSet 1.1046.1.424 (ACPI: Allow irqs >
15...) as cause to my current hang-on-boot problem.  Quick test to see
if this patch fixes...nope ;-(
                                                                                
thanks,
-chris
