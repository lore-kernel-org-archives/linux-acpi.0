From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Fix S3 resume when kernel is big
Date: Thu, 21 Nov 2002 13:44:13 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021121124412.GB1133@atrey.karlin.mff.cuni.cz>
References: <20021120151136.GA862@elf.ucw.cz> <20021120153833.GA4344@suse.de> <1037809055.3702.43.camel@irongate.swansea.linux.org.uk> <20021120155223.GA5678@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021120155223.GA5678-l3A5Bk7waGM@public.gmane.org>
To: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

>  > >  > -	acpi_create_identity_pmd();
>  > >  > +	if (!cpu_has_pse) {
>  > >  > +		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
>  > >  > +		return 1;
>  > >  > +	}
>  > > 
>  > > Mobile K6 family never had PSE iirc, and also VIA Cyrix 3's are being
>  > > dropped into various laptops.
>  > 
>  > Plenty of desktop machines have S3 
> 
> Indeed, that too. So the above assertion seems bogus.

Well, previous version reboots during S3 resume once kernel is > (some
size). I guess that PSE needs fixing but this needed fixing first.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
