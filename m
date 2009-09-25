From: Balbir Singh <balbir@in.ibm.com>
Subject: Re: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power management
	code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce cpuidle to
	POWER.
Date: Fri, 25 Sep 2009 12:50:44 +0530
Message-ID: <661de9470909250020u711031djfbf30f41e06d60bf@mail.gmail.com>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
	 <20090924051238.GA5963@linux.vnet.ibm.com>
	 <20090924142228.5a2ddf59@infradead.org>
Reply-To: balbir@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:55444 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZIYHUl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2009 03:20:41 -0400
In-Reply-To: <20090924142228.5a2ddf59@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: arun@linux.vnet.ibm.com, Len Brown <lenb@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Joel Schopp <jschopp@austin.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>, Gautham R Shenoy <ego@in.ibm.com>, Shaohua Li <shaohua.li@intel.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org

On Thu, Sep 24, 2009 at 5:52 PM, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 24 Sep 2009 10:42:41 +0530
> Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:
>
>> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-22 16:55:27]:
>>
>> Hi Len, (or other acpi folks),
>>
>> I had a question regarding ACPI-cpuidle interaction in the current
>> implementation.
>>
>> Currently, every cpu (i.e. acpi_processor) registers to cpuidle as
>> a cpuidle_device. So every cpu has to go through the process of
>> setting up the idle states and then registering as a cpuidle device.
>>
>> What exactly is the reason behind this?
>>
>
> technically a BIOS can opt to give you C states via ACPI on some cpus,
> but not on others.
>
> in practice when this happens it tends to be a bug.. but it's
> technically a valid configuration

In this day and age of flashable BIOS with recovery BIOS built in,
can't we just print out a big far warning, asking users of such
systems to go back to their vendors and ask for updates or find the
updates and apply them? Does the OS have to do the heavy lifting and
allow users to live with buggy BIOS's.

When you say it is a technically valid configuration, you mean that
the ACPI spec allows for such inconsistency?

Balbir Singh
