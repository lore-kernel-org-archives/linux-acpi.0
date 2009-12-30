From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: introduce kernel parameter acpi_sleep=s3_set_sci_en
Date: Wed, 30 Dec 2009 02:04:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912300202060.15839@localhost.localdomain>
References: <1256610232.19142.77.camel@rzhang-dt>
 <200910270921.42618.rjw@sisk.pl> <1256693810.19142.87.camel@rzhang-dt>
 <200910281952.27856.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:40508 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbZL3HE0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:04:26 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG0072FEBDBWD9@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:04:26 -0600 (CST)
In-reply-to: <200910281952.27856.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> > > > Introduce kernel parameter acpi_sleep=s3_set_sci_en
> > > > 
> > > > some laptop requires SCI_EN being set directly on resume,
> > > > or else they hung somewhere in the resume code path.
> > > > 
> > > > We already have a blacklist for these lattops but we still need
> > > > this option, especially when debugging some suspend/resume problems,
> > > > in case there are systems that need this workaround and are not yet
> > > > in the blacklist.
> > > > 
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
...
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> This one looks better.
> 
> OK, Len, are you going to apply it or do you want me to handle it?


As this isn't actually S3 specific, lets give this a better name, say

acpi_sleep=sci_force_enable

what you think?

thanks,
-Len Brown, Intel Open Source Technology Center


