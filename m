From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/4] X86: Revamp reboot behaviour to match Windows more
 closely
Date: Tue, 22 Mar 2011 23:49:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103222338180.10549@x980>
References: <1299877940-6870-1-git-send-email-mjg@redhat.com>
 <201103112308.18221.rjw@sisk.pl> <20110311221517.GA24173@srcf.ucam.org>
 <201103112318.19678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:50384 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab1CWDtW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2011 23:49:22 -0400
In-reply-to: <201103112318.19678.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

> > > Does this fix a particular problem observed in practice?
> > 
> > Yup. We're seeing an increasing number of machines that don't implement 
> > the legacy keyboard controller at all and fail to reboot if you poke it. 
> > The expectation appears to be that you use the ACPI reboot vector on 
> > these machines.
> 
> So perhaps you can put a pointer or two into the changelog?  That would
> show precisely that it's not just for pure Windows compatibility.

We've been through this before -- many times, in fact.
There are lots of machines that reset only via ACPI,
but when we cut the default over to ACPI, we had
some regressions, and so that change was reverted.

The most recent round started off as a DMI workaround:
http://lkml.org/lkml/2010/1/3/56
and it almost went upstream, but the expected refreshed
patch never materialized.

I think that Matthew's approach is more thorough than
anything else we've tried before wrt compatibility.

But we've found this area to be somewhat fragile in the past,
and so if he succeeds in not breaking any machines,
Matthew is officially my hero:-)

thanks,
Len Brown, Intel Open Source Technology Center

