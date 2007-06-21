From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 08:37:29 -0700
Message-ID: <200706210837.29857.david-b@pacbell.net>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <200706211442.41140.rjw@sisk.pl> <20070621130312.GB18392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:28070 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753731AbXFUPhf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 11:37:35 -0400
In-Reply-To: <20070621130312.GB18392@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>


> > IMO it can be done in two different ways:
> > 1) via a .suspend() argument
> > 2) via a global variable that the drivers can read.

For sufficiently small values of "two" that is.  

Other solutions that have been described on the PM list include

  3) Providing accessors to the information actually needed
     in drivers ... e.g. say whether this clock or power domain
     will be available in that target state.

  4) Act more like "current" ... there's a function returning
     whatever "state" struct is settled on.  (But ideally
     without the pseudo-global.)

I'm amused that nobody really reacted to the technical comments in
my previous posts on this thread.  That's unfortunate, since from
where I sit it feels to me like everyone else is a johnny-come-lately
on this issue, and is now grasping at the quickest and dirtiest ways
to work around the issue instead of coming to grasp with the various
underlying issues.

IMO #3 is strongly preferable.


> Just do 1). Global variables are ugly, and we already have space in
> pm_message_t. 

There is no space in the ugly pm_message_t structure.  Adding to
that would involve creating a **larger** structure and passing it
around on the stack all the time.

Pavel, I know that for some perverse reason you actually like
that structure, and the notion of passing it around *BY VALUE*
instead of by reference.  But that approach has never been
universally acclaimed, and has in fact always had opposition;
the only way you got it merged in the first place was to send
in mountains of patches and ignore the negative feedback.

But I really thought the discussion on new PM methods, back a
couple months now, was going to finally get rid of that.

- Dave
