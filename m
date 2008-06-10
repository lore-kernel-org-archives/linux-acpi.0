From: Len Brown <lenb@kernel.org>
Subject: Re: acpi problem
Date: Tue, 10 Jun 2008 16:29:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806101623491.14381@localhost.localdomain>
References: <20080529173315.GA7420@guevara.dmp> <200805292156.08963.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:37584 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbYFJUaM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jun 2008 16:30:12 -0400
In-reply-to: <200805292156.08963.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: De Martino Pasquale <paco.dmp@gmail.com>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


> > with kernel 2.6.25 my acpi does not work whereas with version <= 2.6.24 all works fine.
> > 
> > Full description:
> > when i run acpi -a this is my output:
> > No support for device type: battery
> > No support for device type: ac_adapter

what do CONFIG_ACPI_BATTERY and CONFIG_ACPI_AC say in your 2.6.24 and 
2.6.25 .config files?

> > "lsmod | grep acpi" says that the acpi module is not loaded so i've tried
> > "modprobe acpi" but the output is:

there is no such thing as the "acpi module", so this is normal

> > FATAL: Error inserting acpi_cpufreq
> > (/lib/modules/2.6.25-2-amd64/kernel/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.ko):
> > Device or resource busy

that's normal, since you've got powernow_k8 loaded

> > I've also tried to pass acpi=on option when kernel boots

there is no such option as "acpi=on", so this is also normal.

"dmesg -s64000 |grep -i acpi" will tell you more about what you
just booted, but since you're running the fan and thermal modules,
it is surely on already.

-Len
