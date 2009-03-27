From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Adjust Kelvin offset to match local implementation
Date: Fri, 27 Mar 2009 11:52:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903271150510.26419@localhost.localdomain>
References: <20090301140318.5cf56287@hyperion.delvare>
 <1236069854.32297.232.camel@rzhang-dt>
 <20090327105520.6fa31a13@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:28033 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbZC0PwY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 11:52:24 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH600BIR9EUE83I@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 10:52:12 -0500 (CDT)
In-reply-to: <20090327105520.6fa31a13@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>


On Fri, 27 Mar 2009, Jean Delvare wrote:

> Hi Rui,
> 
> On Tue, 03 Mar 2009 16:44:14 +0800, Zhang Rui wrote:
> > On Sun, 2009-03-01 at 21:03 +0800, Jean Delvare wrote:
> > > The exact offset between Kelvin and degree Celsius is 273.15. However
> > > ACPI handles temperature values with a single decimal place. As a
> > > consequence, some implementations use an offset of 273.1 and others
> > > use an offset of 273.2. Try to find out which one is being used, to
> > > present the most accurate and visually appealing number.
> > > 
> > > Tested on a Sony Vaio PGC-GR214EP (which uses 273.1) and a Lenovo
> > > Thinkpad T60p (which uses 273.2).
> > Sounds reasonable.
> > 
> > Acked-by: Zhang Rui <rui.zhang@intel.com>
> 
> Thanks. Is this patch queued for 2.6.30 somewhere?

it was, but I had a conflict between this an another and so I dropped this 
one until I could look at it - which I havn't yet.  If you'd like to do
it for me, rebase on top of the acpi test branch.

thanks,
Len Brown, Intel Open Source Technology Center
