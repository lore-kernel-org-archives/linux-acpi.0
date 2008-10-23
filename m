From: Myron Stowe <myron.stowe@hp.com>
Subject: Re: [PATCH 0/3] ACPI: Fix for supporting > 256 processor
	declaration limit
Date: Thu, 23 Oct 2008 09:48:21 -0600
Message-ID: <1224776901.6769.20.camel@localhost>
References: <1224702636.6784.13.camel@localhost>
	 <49000CF8.1070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:31930 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbYJWPsY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 11:48:24 -0400
In-Reply-To: <49000CF8.1070608@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: lenb@kernel.org, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2008-10-23 at 09:34 +0400, Alexey Starikovskiy wrote:
> Hi Myron,
> 
> It is great to see that this functionality found some care after
> 2+ years :)
> Please check your patches to conform to patch submission guidelines,
> namely 80 char string limit... :) scripts/checkpatch.pl is quite good for
> such purpose.
Yes - I did run the patches through scripts/checkpatch.pl.  I had
received feedback from a colleague to ignore the 80 column limit for
printk strings so that they are more 'grep'able.

You're feedback is making me rethink this advice - 'grep'ing for such
occurrences in the kernel is a known issue so most of us have learned to
'grep' for a smaller, sub-string, snippets.  This, along with just
general coding style guidelines, now convinces me that I should conform
to the 80 column limit as it is a good rule (which is why I couldn't
resist creating [PATCH3/3] as part of the series  ;)  ).
> 
> Myron Stowe wrote:
> > Len, Alexey:
> >
> > The following three item patch series fixes an issue with the introduction
> > of > 256 processor declaration support: "Allow processor to be declared with
> > the Device() instead of Processor()" (git SHA 11bf04c4).
> >
> > The root issue is in the lsapic mapping logic of drivers/acpi/processor_core.c.
> > Currently, the logic tries both types of matches irregardless of declaration
> > type and relies on one failing.  According to the spec - lsapic mapping is
> > dependent on how the processor object was declared: CPUs declared using the
> > "Processor" statement should use the Local SAPIC's 'processor_id', and CPUs
> > declared using the "Device" statement should use the 'uid'.
> >
> > Reference: Section 8.4 Declaring Processors; Section 5.2.11.13 Local SAPIC
> > Structure.  "Advanced Configuration and Power Interface Specification",
> > Revision 3.0b, October 2006.
> >
> >
> > [PATCH 1/3] disambiguates the processor declaration type that is currently
> > conflated so that subsequent logic can behave based explicitly on the
> > declaration's type.  I expect the disambiguation this patch introduces will
> > also be advantageous when extending the > 256 processor support for x86 via
> > x2APIC.
> >
> > [PATCH 2/3] addresses the root issue as stated above.  With respect to this
> > patch I'm ambivalent about the 'printk' introduced in "map_lsapic_id()" -
> > perhaps it should be removed?
> >
> >   
> Errors causing change from default behaviour should be visible, so
> printk is ok, please only make it conform to 80 char string length limit.
> > [PATCH 3/3] is non-functional white space/spelling fixes in the related code. 
> >
> >
> > While the specific fix is ia64 focused the underlying code affected is common
> > to both x86 and ia64.
> That was intentional to have it common, as the less frequently used
> case will rotten without care.
Agreed - it should be common (was just making to comment as to why I
also tested x86 and to let others know this patch indirectly
touches/affects x86).
> >   I have tested on the following platform/namespace
> > combinations:
> >   ia64 with "Processor" type namespace processor declarations,
> >   ia64 with "Device" type namespace processor declarations,
> >   x86 with "Processor" type namespace processor declarations.
> >
> >   
> I had no machine with second variant, so it probably didn't work there, 
> right?
Yes - we now have a platform that uses "Device" declarations for the
first time and the kernel 'panick'ed thus this patch.  You had all the
proper infrastructure in place - just a pretty simple omission which,
without something to test against would be easy to not see.
> > Note that this patch series does *not* handle "Device" type processor
> > declarations that contain a string type _UID object under the processor
> > device's scope (I am currently not aware of any platforms that have such to
> > test against).
> >
> >   
> Original didn't do it either -- it is too difficult and does not give 
> any advantage
> to HW vendors over numeral ID.
Yeah.  I was going to tackle this and it turned out to get pretty messy
fast.  Fortunately the error path printk in acpi_processor_get_info()
when a "Device" declaration with a _UID that is *not* an integer is
encountered will trigger and indicate exactly where the issue is at some
future date when a vendor utilizes this combination.

Thanks for the feedback!
Myron
> 
> Regards,
> Alex.
> 
-- 
Myron Stowe                             HP Open Source & Linux Org

