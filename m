From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 0/5] Detect hwmon and i2c bus drivers interfering with
  ACPI Operation Region resources
Date: Fri, 26 Oct 2007 21:23:06 +0200
Message-ID: <20071026212306.40b4a12d@hyperion.delvare>
References: <1193236319.4590.225.camel@queen.suse.de>
	<20071024205723.458fab97.akpm@linux-foundation.org>
	<20071025155135.019baca3@hyperion.delvare>
	<20071025132410.7ae184a8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:3305 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757678AbXJZTXJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2007 15:23:09 -0400
In-Reply-To: <20071025132410.7ae184a8.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org

Hi Andrew,

On Thu, 25 Oct 2007 13:24:10 -0700, Andrew Morton wrote:
> On Thu, 25 Oct 2007 15:51:35 +0200, Jean Delvare wrote:
> > Thanks for picking these patches, having them in -mm for some time is
> > exactly what we need. Let's see how many systems are affected by the
> > resource conflicts and how we can fix them
> 
> No probs.  The main thing is to ensure that we have sufficient debug
> support in that patch so that if a tester does report a problem, we (ie:
> you ;) can resolve it on the first pass.  So feel free to make it really
> noisy - we can always drop the debug stuff later on.

Well, I'm not exactly sure what we can do when people report conflicts,
except telling them "don't do that". I guess each case will be
different. We will have to ask reporters for their DSDT table, look at
it and... do something. I'll need (much) help from the ACPI developers.
At this point we are mainly trying to gather enough data to fully
understand how big the problem is. Solutions will come later.

> Also, please try to avoid adding anythig which would disrupt that tester
> from going on and testing all the other new code.  ie: try to fail
> gracefully and fall back to the old behaviour.

User will simply miss their SMBus controller or their hardware
monitoring device, it wont prevent them from using their systems, but
that should be enough to get them to report (I hope).

-- 
Jean Delvare
