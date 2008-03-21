From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 2)
Date: Fri, 21 Mar 2008 01:26:31 +0100
Message-ID: <200803210126.32683.rjw@sisk.pl>
References: <200803210101.04706.rjw@sisk.pl> <1206058863.16475.165.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38128 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917AbYCUA0r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Mar 2008 20:26:47 -0400
In-Reply-To: <1206058863.16475.165.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Friday, 21 of March 2008, Johannes Berg wrote:
> 
> > + * All of the above callbacks, except for @complete(), return error codes.
> > + * However, the error codes returned by the resume operations, @resume(),
> > + * @thaw(), and @restore(), are only printed in the system logs, since the PM
> > + * core cannot do anything else about them.
> 
> Why bother and not just make them return void, the error printing can
> most likely be done much much better in the callback since that possibly
> has information on why it failed.
> 
> > + * All of the above callbacks, return error codes, but the error codes returned
> > + * by the resume operations, @resume_noirq(), @thaw_noirq(), and
> > + * @restore_noirq(), are only printed in the system logs, since the PM core
> > + * cannot do anything else about them.
> 
> Same here, of course.

The errors returned are used by TRACE_RESUME(), for example.

Well, perhaps the comments should be changed instead. :-)

Thanks,
Rafael
