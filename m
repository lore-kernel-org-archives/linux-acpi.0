From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Reminder for feature dev->power.power_state removal date July 2007
Date: Fri, 03 Jul 2009 07:36:48 +0530
Message-ID: <1246586808.2530.8.camel@jaswinder.satnam>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41779 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756238AbZGCCSB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jul 2009 22:18:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-acpi <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hello Pavel,

What:   dev->power.power_state
When:   July 2007
Why:    Broken design for runtime control over driver power states, confusing
        driver-internal runtime power management with:  mechanisms to support
        system-wide sleep state transitions; event codes that distinguish
        different phases of swsusp "sleep" transitions; and userspace policy
        inputs.  This framework was never widely used, and most attempts to
        use it were broken.  Drivers should instead be exposing domain-specific
        interfaces either to kernel or to userspace.
Who:    Pavel Machek <pavel@suse.cz>

If you are facing any issue regarding feature removal kindly update the
"Documentation/feature-removal-schedule.txt" like what you are waiting
for.

Thanks,
--
JSR

http://userweb.kernel.org/~jaswinder/

