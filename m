From: Ducrot Bruno <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Fix S3 resume when kernel is big
Date: Thu, 21 Nov 2002 14:15:02 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021121131502.GE707@poup.poupinou.org>
References: <20021120151136.GA862@elf.ucw.cz> <20021120153833.GA4344@suse.de> <20021121124506.GC1133@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021121124506.GC1133-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 21, 2002 at 01:45:06PM +0100, Pavel Machek wrote:
> Hi!
> 
> >  > -	acpi_create_identity_pmd();
> >  > +	if (!cpu_has_pse) {
> >  > +		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
> >  > +		return 1;
> >  > +	}
> > 
> > Mobile K6 family never had PSE iirc, and also VIA Cyrix 3's are being
> > dropped into various laptops.
> 
> So S3 will refuse to suspend on those machines. Right now it will
> suspend and not wakeup if moon is bad phase.
> 							Pavel

FYI, current swsusp for 2.4 require that cpu has pse _or_ pse36.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
