From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Date: Fri, 6 Dec 2002 19:57:02 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021206185702.GE17595@poup.poupinou.org>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain> <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021206000618.GB15784-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 06, 2002 at 01:06:18AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > Doesn't that imply your fix is broken to begin with?
> > > 
> > > ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> > > swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> > > overdesign to me, OTOH if you do the work it is okay with me.
> > 
> > You broke the design. S3 support was developed long before swsusp was in 
> > the kernel, and completely indpendent of it. It should have remained that 
> > way. 
> > 
> > S3 support is a subset of what is need for S4 support. 
> 
> That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> but not for S4. Big part of driver support is only needed for S3.
> 
> > swsusp is an implementation of S4 support. In theory, there could be 
> > multiple implementations that all use the same core (saving/restoring 
> > state). 
> 
> There were patches for S4bios floating around, but it never really
> worked, IIRC.

No.  It work.  I do not resubmmited patches because I think that
swsusp is better.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
