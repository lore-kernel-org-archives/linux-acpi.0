From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH] ACPI / PM: Do not power manage devices in unknown initial states
Date: Fri, 01 Feb 2013 22:44:55 +0100
Message-ID: <6427459.8Ia2IB77g6@vostro.rjw.lan>
References: <3676077.i6vcpp7Nrn@vostro.rjw.lan> <2135454.ENo8eA9AXp@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40901 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757562Ab3BAVin (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Feb 2013 16:38:43 -0500
In-Reply-To: <2135454.ENo8eA9AXp@al>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wu <lekensteyn@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Friday, February 01, 2013 07:23:52 PM Peter Wu wrote:
> On Thursday 31 January 2013 23:32:40 Rafael J. Wysocki wrote:
> > In general, for ACPI device power management to work, the initial
> > power states of devices must be known (otherwise, we wouldn't be able
> > to keep track of power resources, for example).  Hence, if it is
> > impossible to determine the initial ACPI power states of some
> > devices, they can't be regarded as power-manageable using ACPI.
> > 
> > For this reason, modify acpi_bus_get_power_flags() to clear the
> > power_manageable flag if acpi_bus_init_power() fails and add some
> > extra fallback code to acpi_bus_init_power() to cover broken
> > BIOSes that provide _PS0/_PS3 without _PSC for some devices.
> > 
> > Verified to work on my HP nx6325 that has this problem.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Tested-by: Peter Wu <lekensteyn@gmail.com>
> 
> I applied it on top of branch linux-next of repo linux-pm.
> 
> Fixes the issue I had with bbswitch in Linux 3.8. Can a backport patch be made 
> available for 3.8?

Yes, after this commit enters the mainline.  Please ping me some time around
3.9-rc1.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
