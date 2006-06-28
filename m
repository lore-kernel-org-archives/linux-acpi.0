From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 02/18] acpi memory hotplug cannot manage _CRS with plural resoureces
Date: Wed, 28 Jun 2006 02:13:26 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6DCECB0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21387 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422700AbWF1GNo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Jun 2006 02:13:44 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com, kaneshige.kenji@jp.fujitsu.com

Andrew,
Thanks for forwarding this series to Linus.

>btw, this is, by my count, the seventh time I've sent this patch.

what is your point?

> The first was on March 21.

March 21st was the 1st day of the 2.6.17 integration window,
so unless this series deserved very little testing, it
missed 2.6.17 by definition.

Also, I couldn't apply this patch series because it depended
on other changes in -mm.  Yes, I should have Acked it for you.
However, when it didn't apply I stopped looking at it.

June 17th, 2.6.18 opened

You send this series to Linus today.
So given the current process and the 8-week 2.6.17 cycle,
this patch made it into Linus' tree within days of the speed of light.

I'm happy to work with you on improving the process.
I think I could have acked this one for you, but that
is about it.

thanks,
-Len
