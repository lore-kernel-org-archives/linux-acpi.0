From: Peter Jones <pjones@redhat.com>
Subject: RE: Output ACPI info via sysfs
Date: Fri, 12 May 2006 11:06:09 -0400
Message-ID: <1147446369.3604.20.camel@localhost.localdomain>
References: <44649D2E.90908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:9135 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932115AbWELPGT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 May 2006 11:06:19 -0400
In-Reply-To: <44649D2E.90908@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>

(sorry for breaking threading, I'm not on the list and this was
forwarded to me)

> >Currently, after booting a system there is no way to tell what 
> >hardware 
> >is currently in the system.  The current output from sysfs only 
> >indicates what knowledge the kernel has of the system (ie, is 
> >limited by 
> >NR_CPUS, etc.).  However, during ACPI initialization a lot of data is 
> >output to the console about the precise number of CPUs, lapics, etc.
> 
> Can you give an example of a person or program that can not
> access a specific piece of information that they need?

Anaconda can't determine the number of CPUs or sockets actually present
(in use or not, enabled or disabled) in a system, which we need to do in
order to determine what kernel we should install.

On x86_64 in RHEL, installation uses the default kernel, which is
compiled with support for 16 CPUs.  We can't change that because
changing CONFIG_NR_CPUS changes the module ABI, and breaks modules built
by our ISVs.  But on systems with more CPUs than that, our users are ok
with us breaking that ABI to use more CPUs, as long as it does not
effect systems with 16 or fewer processors.  So we need to probe the
number of processors and install the appropriate kernel.

I've got code to read the ACPI tables from userland right now, but it
isn't terribly reliable.  Some systems lock up if you read the tables
while X is running, and some systems sometimes give erroneous data.  In
both cases, it seems the earlier you read the tables the better, and of
course the kernel reads them while it's still only got 1 CPU running,
which is the best possible case.  The kernel hasn't triggered any of the
failures we've seen, and since it already has to read the tables, this
would be the best place for userland to get that data.

-- 
  Peter

