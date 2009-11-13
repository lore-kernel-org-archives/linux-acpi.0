From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] intermittent suspend problem again
Date: Fri, 13 Nov 2009 20:59:46 +0100
Message-ID: <200911132059.46377.rjw@sisk.pl>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200911111547.21149.rjw@sisk.pl> <87my2qwff8.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48418 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295AbZKMT6W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Nov 2009 14:58:22 -0500
In-Reply-To: <87my2qwff8.fsf@tac.ki.iif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>, yakui.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Friday 13 November 2009, Ferenc Wagner wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > Yes, echo "core" to /sys/power/pm_test before executing s2disk.
> 
> It snapshots the system and returns, producing the same console output
> as s2ram (is this the expected behaviour?)  I ran this several times in
> a loop, and experienced no problems at all.  Maybe it depends on the
> amount of memory used...  I saw a freeze saying "99% done" (ie. not
> 100%), btw.

The number is not always accurate because of rounding errors.  I think we can
safely assume that it always happens after the entire image has been written.

> Are other pm_test values meaningful with s2disk?  Is this
> handled explicitly in s2disk, or does simply the kernel act as if it was
> resumed instead of providing the system image after SNAPSHOT_CREATE_IMAGE?

The latter.

> > On Wednesday 11 November 2009, Ferenc Wagner wrote:
> >
> >> I already did the test for STR (see
> >> http://bugs.freedesktop.org/show_bug.cgi?id=22126#c3), but will redo
> >> with the current kernel tonight.
> >
> > OK, thanks.
> 
> No change on this front, FWIW.  But rc7 is out now, I'll test again.

Not sure if that's going to work, but yes please test it.

Thanks,
Rafael
