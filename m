From: Constantinos Antoniou <costas-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Date: 08 Dec 2002 15:46:20 -0500
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1039380380.1614.57.camel@nefeli>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz>
	 <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain>
	 <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
	 <20021206185702.GE17595@poup.poupinou.org>
	 <20021208194944.GB19604@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20021208194944.GB19604-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2002-12-08 at 14:49, Pavel Machek wrote:
> Hi!
> 
> > > > > > Doesn't that imply your fix is broken to begin with?
> > > > > 
> > > > > ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> > > > > swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> > > > > overdesign to me, OTOH if you do the work it is okay with me.
> > > > 
> > > > You broke the design. S3 support was developed long before swsusp was in 
> > > > the kernel, and completely indpendent of it. It should have remained that 
> > > > way. 
> > > > 
> > > > S3 support is a subset of what is need for S4 support. 
> > > 
> > > That's not true. acpi_wakeup.S is nasty piece of code, needed for S3
> > > but not for S4. Big part of driver support is only needed for S3.
> > > 
> > > > swsusp is an implementation of S4 support. In theory, there could be 
> > > > multiple implementations that all use the same core (saving/restoring 
> > > > state). 
> > > 
> > > There were patches for S4bios floating around, but it never really
> > > worked, IIRC.
> > 
> > No.  It work.  I do not resubmmited patches because I think that
> > swsusp is better.
> 
> I think that s4bios is nice to have. Its similar to S3 and easier to
> set up than swsusp... It would be nice to have it.

(I do not know much, but) another reason may be that some laptops do not
support S3, while they support S4? for example, in my Compaq Presario
1700T:

$ more /proc/acpi/info
ACPI-CA Version:         20011018
Sx States Supported:     S0 S1 S4 S5

(unpatched 2.4.19, if this has anything to do)

Costas

> 								Pavel
-- 
Constantinos Antoniou
Ph.D. Candidate
Massachusetts Institute of Technology
Intelligent Transportation Systems Program
77 Massachusetts Ave., NE20-208, Cambridge, MA 02139
(T) 617-252-1113 * (F) 617-252-1130 * (email) costas-3s7WtUTddSA@public.gmane.org
