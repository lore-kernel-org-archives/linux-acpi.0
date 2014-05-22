From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 6/7 v3] trace, eMCA: Add a knob to adjust where to save
 event log
Date: Thu, 22 May 2014 13:11:40 +0200
Message-ID: <20140522111140.GH4383@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-7-git-send-email-gong.chen@linux.intel.com>
 <20140521110630.GG21205@pd.tnic>
 <20140521234626.GA1644@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35124 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbaEVLLn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2014 07:11:43 -0400
Content-Disposition: inline
In-Reply-To: <20140521234626.GA1644@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Wed, May 21, 2014 at 07:46:26PM -0400, Chen, Gong wrote:
> On Wed, May 21, 2014 at 01:06:31PM +0200, Borislav Petkov wrote:
> > > +	if (ras_userspace_consumers() == 0) {
> > 
> > 	if (!ras_userspace_consumers())
> > 
> No, it is not a pointer so I don't think it is very
> meaningful just to save some bytes.

Btw, this is exactly why your patches take too long to review - you like
to debate more instead of listening to the maintainers. Next time you
want to speed up the process, just think about that.

I think the amount of time I wasted to explain all the crap to you is
more than I've spent actually reviewing your patches. How about you
do what you're told for a change, not change agreed upon stuff after
review because then I have to go and review it all over again from the
beginning and thus make both our lives easier?

As to the question why you should listen to the maintainers: that's
because we get to maintain your code after you go and do something else
so it better be readable to us.

Now to answer your direct question:

	if (!ras_userspace_consumers())

reads straight away as "if there are no ras userspace consumers" instead
of "if the number of the ras userspace consumers is zero".

Got it?!

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
