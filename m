From: Thomas Renninger <trenn@suse.de>
Subject: Re: problem about ACPI processor procfs
Date: Tue, 27 Feb 2007 15:45:47 +0100
Message-ID: <1172587547.10619.429.camel@d36.suse.de>
References: <58A36151585E4047913F40517D307BAE43BDE8@pdsmsx404.ccr.corp.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:55028 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbXB0Ops (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Feb 2007 09:45:48 -0500
In-Reply-To: <58A36151585E4047913F40517D307BAE43BDE8@pdsmsx404.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>

On Tue, 2007-02-27 at 17:33 +0800, Zhang, Rui wrote:
> Hello, list
> 
> I met some problems when duplicating ACPI processor procfs interface in sysfs.
> #cat /proc/acpi/processor/CPU0/limit
> Active limit:		P0:T0
> User limit:		P0:T0
> Thermal limit:	P0,T0
> 
> IMO, "Tx" is easy to understand. It indicates the active T-state, T-state set by user and T-state set by thermal (in passive mode).
> 
> But what does the "Px" stand for? After reading the code in processor_thermal.c, I don't think user or thermal will change its value.
> And I don't know if it's still needed when porting to sysfs.

Px are P-states, this is cpufreq.
Writing to it will probably interfere with /sys/devices/../cpufreq/*.
x should correspond to the amount of entries in
/sys/devices/../cpufreq/scaling_available_frequencies.

Can't we just get rid of this? Is there any userspace prog that made use
of this in /proc and if was it really useful in any way?

   Thomas

