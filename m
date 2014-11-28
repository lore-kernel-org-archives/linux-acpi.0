From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] ACPI / processor: remove incorrect comparison of phys_id
Date: Sat, 29 Nov 2014 00:26:13 +0100
Message-ID: <25335106.4A2H4B9kq8@vostro.rjw.lan>
References: <1416926930-792-1-git-send-email-sudeep.holla@arm.com> <9584090.hqdaL9kipZ@vostro.rjw.lan> <5478C765.30504@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55355 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751278AbaK1XE4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Nov 2014 18:04:56 -0500
In-Reply-To: <5478C765.30504@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday, November 28, 2014 07:05:09 PM Sudeep Holla wrote:
> Hi Rafael,
> 
> On 26/11/14 22:26, Rafael J. Wysocki wrote:
> > On Wednesday, November 26, 2014 10:33:04 AM Sudeep Holla wrote:
> >> Hi Hanjun,
> >>
> >> On 26/11/14 09:53, Hanjun Guo wrote:
> >>> Hi Sudeep,
> >>>
> >>> On 2014-11-25 22:48, Sudeep Holla wrote:
> 
> [...]
> 
> >>>>
> >>>> This patch removes that incorrect comparision in
> >>>> acpi_processor_hotadd_init as the lone user of this function is
> >>>> already checking for correctness of phys_id before calling it.
> >>>
> >>> if (apic_id < 0) acpi_handle_debug(pr->handle, "failed to get CPU
> >>> APIC ID.\n");
> >>>
> >>> it only check the value and print debug message but no returns, so I
> >>> think the check in the following patch is still needed.
> >>>
> >>
> >> Agreed, but that's something we need to fix in the logic and not by
> >> changing these identifiers to signed values in the structures.
> >
> > I'd rather not change data structures just because of what one funtion returns.
> >
> > Instead, I'd do something like
> >
> > 	#define CPU_PHYS_ID_INVALID	(u32)(-1)
> >
> > change the function in question to return CPU_PHYS_ID_INVALID instead of -1
> > and change the check to
> >
> > 	if (phys_id == CPU_PHYS_ID_INVALID)
> > 		...
> >
> 
> Do I need to rebase this on top of Hanjun's cleanups to convert apic_id
> to phys_id ? Since the variable is getting renamed it will conflict.

Yes, it's better to rebase IMO.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
