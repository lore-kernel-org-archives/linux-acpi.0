From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 14365] New: resume from suspend to ram broken after suspend to disk
Date: Sat, 10 Oct 2009 23:30:33 +0200
Message-ID: <200910102330.33297.rjw@sisk.pl>
References: <bug-14365-10286@http.bugzilla.kernel.org/> <20091010103905.7bc562c3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54307 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911AbZJJV3d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Oct 2009 17:29:33 -0400
In-Reply-To: <20091010103905.7bc562c3.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Saturday 10 October 2009, Andrew Morton wrote:
> On Sat, 10 Oct 2009 13:40:45 GMT bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=14365
> > 
> >            Summary: resume from suspend to ram broken after suspend to
> >                     disk
> >            Product: Power Management
> >            Version: 2.5
> >     Kernel Version: 2.6.31
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Hibernation/Suspend
> >         AssignedTo: power-management_other@kernel-bugs.osdl.org
> >         ReportedBy: corsac@debian.org
> >         Regression: No
> 
> It worries me that we have both "Power management, Hibernation/Suspend"
> and acpi-power-sleep-wake.
> 
> Are these duplicative?

acpi-power-sleep-wake is more specific.  Hibernation/Suspend bugs need not be.
about ACPI.

> Should we kill one off?

I don't think that's necessary.

> Do the acpi developers monitor the "Power Management" category?

Yes, they do, to my knowledge.
