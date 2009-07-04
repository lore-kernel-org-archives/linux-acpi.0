From: mfwitten@gmail.com
Subject: Re: 2.6.30: hibernation/swsusp lockup due to acpi-cpufreq
Date: Fri, 03 Jul 2009 19:32:37 -0700 (PDT)
Message-ID: <4a4ebf45.08045a0a.3d7c.362e@mx.google.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:53744 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759550AbZGDCcf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Jul 2009 22:32:35 -0400
Received: by yxe26 with SMTP id 26so3873696yxe.33
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2009 19:32:38 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Tue, 16 Jun 2009 23:39:59 +0200, Rafael J. Wysocki wrote
(http://www.spinics.net/lists/linux-acpi/msg22661.html):

> In fact, we need to do this entire thing differently.
> 
> The basic problem is that cpufreq_suspend() is a sysdev thing, so it will 
> always be called with iterrupts off and *only* for CPU0.  So, it looks like
> the majority of things we do there is just unnecessary (at least).

What's the status? This bug is driving me nuts.

Thanks,
Michael Witten

