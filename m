From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 8995] New: /proc/acpi/alarm worked; update to 2.6.22.2 and /sys/class/rtc/rtc0/wakealarm don't
Date: Sun, 4 Nov 2007 20:56:55 +0100
Message-ID: <200711042056.56763.rjw@sisk.pl>
References: <bug-8995-10286@http.bugzilla.kernel.org/> <200709091332.44709.rjw@sisk.pl> <200711041125.35163.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60615 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbXKDTkG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Nov 2007 14:40:06 -0500
In-Reply-To: <200711041125.35163.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, huffcslists@gmail.com, Alessandro Zummo <a.zummo@towertech.it>, linux-acpi@vger.kernel.org, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, bugme-daemon@bugzilla.kernel.org, Len Brown <lenb@kernel.org>

On Sunday, 4 of November 2007, David Brownell wrote:
> Re http://bugzilla.kernel.org/show_bug.cgi?id=8995 ...
> 
> On Sunday 09 September 2007, Rafael J. Wysocki wrote:
> > I think the suspend/hibernation code ordering changes after
> > 2.6.20 are to blame here.
> 
> So what's the status of this now ... are we back to having
> the /sys/class/rtc/rtc0/wakealarm work with ACPI again, with
> /sys/power/state written as "standby", "mem", or "disk"

Yes, it should work now.

The fix for the "disk" case is in the mainline:

9cd9a0058dd35268b24fa16795a92c800f4086d4
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Thu Oct 18 03:04:56 2007 -0700

    Hibernation: Enter platform hibernation state in a consistent way.

