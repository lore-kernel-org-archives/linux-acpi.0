From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Output ACPI info via sysfs
Date: Sat, 13 May 2006 00:17:39 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F22C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50289 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932324AbWEMERk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 00:17:40 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
Cc: linux-acpi@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>

 
>Anaconda can't determine the number of CPUs or sockets actually present
>(in use or not, enabled or disabled) in a system, which we 
>need to do in
>order to determine what kernel we should install.

do you care about logical processors only,
or do you also care if the processors are HT or multi-core
in the same package?

>On x86_64 in RHEL, installation uses the default kernel, which is
>compiled with support for 16 CPUs.  We can't change that because
>changing CONFIG_NR_CPUS changes the module ABI, and breaks 
>modules built
>by our ISVs.  But on systems with more CPUs than that, our users are ok
>with us breaking that ABI to use more CPUs, as long as it does not
>effect systems with 16 or fewer processors.  So we need to probe the
>number of processors and install the appropriate kernel.
>
>I've got code to read the ACPI tables from userland right now, but it
>isn't terribly reliable.  Some systems lock up if you read the tables
>while X is running, and some systems sometimes give erroneous data.  In
>both cases, it seems the earlier you read the tables the better, and of
>course the kernel reads them while it's still only got 1 CPU running,
>which is the best possible case.  The kernel hasn't triggered 
>any of the
>failures we've seen, and since it already has to read the tables, this
>would be the best place for userland to get that data.

This makes zero sense to me.
Except for very very large systems the enumerate the processors in the
DSDT
(eg altix with > 256),
the processors are enumerated in the MADT, which is completely static.
In no way should dumping
it and parsing it in user-space have any effect on the integrity
of the system.

in pmtools, acpidump does this, and the madt utility below --
a rip-off of the kernel parsing code -- looks at it:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

There is no reason you couldn't combine them into a single
utility to answer the question that you are asking.
It requires 0 kernel support, and doesn't even require
running in ACPI mode.

-Len
