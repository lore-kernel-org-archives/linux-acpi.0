From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] ACPI: battery: add power_{now, avg} properties to power_class
Date: Tue, 16 Dec 2008 21:49:01 +0100
Message-ID: <200812162149.01926.rjw@sisk.pl>
References: <20081216162756.12100.49260.stgit@thinkpad> <alpine.LFD.2.00.0812161237220.4414@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56880 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbYLPUtb (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 15:49:31 -0500
In-Reply-To: <alpine.LFD.2.00.0812161237220.4414@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Linux-acpi@vger.kernel.org

On Tuesday, 16 of December 2008, Len Brown wrote:
> 
> On Tue, 16 Dec 2008, Alexey Starikovskiy wrote:
> 
> > +What:	current_{now,avg} attributes for batteries, reporting in energy units
> > +When:	2.6.29
> > +Why:	Batteries, reporting in energy units, will report (dis)charge rate as
> > +	power (Watts), and not as current (Amperes), thus new power_{now,avg}
> > +	attributes should be used for such batteries to avoid the confusion.
> > +Who:	Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> I think that a single kernel release cycle is too quick
> for a user/kernel API change  unless you're trying to fix
> something that is new and you have a pretty good idea
> that nobody is using it yet.  Kernel programmers typically
> want to talk about O(6 months) and Linus comes back and
> talks aboutg O(10 years)...

Well, IMO that could be discussed with the people who work on battery monitors.

If they agree to update their stuff in shorter time, we can remove the
'current_now' thing more quickly.

Thanks,
Rafael
