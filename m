From: Len Brown <lenb@kernel.org>
Subject: Re: Buggy BIOS on the HP TX2500-series
Date: Wed, 08 Oct 2008 21:10:33 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810082105150.3041@localhost.localdomain>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com>
 <20081008192641.GA1932@srcf.ucam.org> <1223513955.2735.28.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172069pub.verizon.net ([206.46.172.69]:33521 "EHLO
	vms172069pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbYJIBKj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 21:10:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172069.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8G00GT05XQEIV2@vms172069.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 08 Oct 2008 20:10:39 -0500 (CDT)
In-reply-to: <1223513955.2735.28.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>



On Thu, 9 Oct 2008, Zhang Rui wrote:

> On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
> > A patch went into the kernel earlier this year to ignore critical trip
> > points that were below 0.

> well, I think this patch is wrong.

i agree that it treated the symptom and not the cause,
but the patch is still good.

> a critical trip point below 0 Celsius doesn't mean it's invalid.

using human made technology here on Earth, it is indeed invalid;-)

> windows can work well on this laptop.
> please look at:
> http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13

> IMO, we need to fix the ACPICA code first of all.
> 
> Ming, what do you think of the patch in comment #15 and #16?

the root cause of this issue is that the BIOS AML is broken
and uses an implicit return.  Linux broke our windows bug
compatibility on implicit return, and we need to fix that.

-Len

