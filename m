From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/22] cpuidle take2: Core cpuidle infrastructure
Date: Thu, 15 Mar 2007 12:47:42 -0400
Message-ID: <200703151247.42326.lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org> <11734992601441-git-send-email-lenb@kernel.org> <p7364928z8a.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50360 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030649AbXCOQtH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Mar 2007 12:49:07 -0400
In-Reply-To: <p7364928z8a.fsf@bingen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org, Adam Belay <abelay@novell.com>, Shaohua Li <shaohua.li@intel.com>

On Thursday 15 March 2007 08:31, Andi Kleen wrote:
> Len Brown <lenb@kernel.org> writes:
> > +
> > +/**
> > + * cpuidle_idle_call - the main idle loop
> > + *
> > + * NOTE: no locks or semaphores should be used here
> > + * FIXME: DYNTICKS handling
> 
> I don't think you can merge anything anymore with such a FIXME.

Certainly it need to work well with NOHZ before it can go upstream.
Indeed, NOHZ is one of the reasons for doing cpuidle in the first place.

But then NOHZ is probably going to take some time to mature also,
certainly it can't be considered mature until it is also in the 64-bit kernel.

The question becomes if NOHZ matures w/o cpuidle -- do we need
to modify the existing tick-based ACPI idle code before cpuidle?

> Besides cpuidle is a pretty radical change outside ACPI and I would recommend to 
> make a few review cycles over linux-kernel and likely linux-arch. 

I agree.  acpi-test and -mm would not be sufficient exposure for generic code.

> For me it's not clear it has enough advantages for its amount of code

Understood.  Measurements will tell.
This is the very reason we created tools which can simultaneously
measure performance and battery life: http://sourceforge.net/projects/bltk

I think that for cpuidle to go upstream, its default should not require any user-space changes
to work as well as the old code.  If some sysfs hooks are available to get added
value, such as useful statistics or modifying policy, that is something that
user-space can safely ignore and not break.

-Len
