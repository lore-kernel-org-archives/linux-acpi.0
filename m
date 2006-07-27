From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Generic battery interface
Date: Thu, 27 Jul 2006 19:20:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601168A85@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga08.intel.com ([134.134.136.24]:4403 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750772AbWG0XUN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2006 19:20:13 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

>Anyone volunteers write battery layer? If so, I'd go with /dev/XXX,

I'd like to take a swing at it.
If it catches on, I'd be happy to maintain it.

I think we should be able to make different underlying battery
instrumentation make sense to user-space -- even Zaurus-style systems.

I'm not religious about /dev vs. /sys.  At the end of the day I think
that an easy and consistent programming I/F between user and kernel
is the highest priority, and at the moment for this type of thing
I think /dev is simpler than /proc or /sys files.  But if using
/dev has some fatal flaw, I'll be happy to change to /sys.
Also, there is no law that says we can't do some of both
if that turns out to be useful.

-Len
