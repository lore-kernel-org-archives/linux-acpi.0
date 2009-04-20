From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] PM/Suspend: Introduce two new platform callbacks to
	avoid breakage (Re: 900af0d breaks some embedded suspend/resume)
Date: Mon, 20 Apr 2009 09:35:23 +0100
Message-ID: <20090420083523.GB16002@flint.arm.linux.org.uk>
References: <20090417231009.GB6900@flint.arm.linux.org.uk> <200904181626.10388.rjw@sisk.pl> <20090418144132.GC7148@flint.arm.linux.org.uk> <200904182047.48009.rjw@sisk.pl> <1240183907.8867.22.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754059AbZDTIhq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1240183907.8867.22.camel@nigel-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham-lkml@crca.org.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 20, 2009 at 09:31:47AM +1000, Nigel Cunningham wrote:
> >  	}
> >  
> > -	if (suspend_ops->prepare) {
> > -		error = suspend_ops->prepare();
> > +	if (suspend_ops->prepare_late) {
> > +		error = suspend_ops->prepare_late();
> >  		if (error)
> >  			goto Power_up_devices;
> >  	}
> 
> Doesn't this invalidate testing that's already been done? Drivers
> implementing prepare() (arm omap1, pxa, omap2, s3c and powerpc mpc52xx
> and lite5200) are now going to have it called pre device_power_down.

... which is the way it has always been done prior to the change which
broke stuff.  So this patch is putting the ordering back the way it was
which has been well proven to work on these platforms.

So we're not invalidating any testing.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
