From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Make Embedded Controller command timeout delay
 configurable
Date: Fri, 22 Oct 2010 01:25:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010220122420.7016@localhost.localdomain>
References: <201010211824.57893.trenn@suse.de> <201010212153.03664.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:53343 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0JVFZ5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2010 01:25:57 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAO00009F36ET81@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 22 Oct 2010 00:25:55 -0500 (CDT)
In-reply-to: <201010212153.03664.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

On Thu, 21 Oct 2010, Rafael J. Wysocki wrote:

> On Thursday, October 21, 2010, Thomas Renninger wrote:
> > Here and then there show up machines which need higher timeout values.
> > Finding this on affected machines can be cumbersome, because
> > ACPI_EC_DELAY is a compile option -> make it configurable via boot param.
> 
> I think the users should not be allowed to decrease the delay below certain
> reasonable limit (perhaps current value of ACPI_EC_DELAY).
> 
> > This can even be provided writable at runtime via:
> > /sys/modules/acpi/parameters/ec_delay
> 
> Would it be safe?

It is no less safe than the other sysfs knobs
that root can turn to hose the machine.

if we were concerned about the modparam becoming
a run-time API, we could make it boot-time only
and only readable at run-time.

At the moment I'm very concerned about the number of EC bugs,
and so in general I'm delighted to see knobs to help debug.

cheers,
Len Brown, Intel Open Source Technology Center
