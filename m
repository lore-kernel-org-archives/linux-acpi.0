From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: problem about ACPI processor procfs
Date: Tue, 27 Feb 2007 07:19:03 -0800
Message-ID: <EB12A50964762B4D8111D55B764A84540150731B@scsmsx413.amr.corp.intel.com>
References: <1172587547.10619.429.camel@d36.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37914 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbXB0PTH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Feb 2007 10:19:07 -0500
Content-class: urn:content-classes:message
In-Reply-To: <1172587547.10619.429.camel@d36.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>


Yes. All the things needed are in cpufreq already and I don't think we
need to export things like P-state power etc in /sys. I think we should
be able to remove all P-state stuff in /proc/acpi without adding
anything in cpufreq. 

Thanks,
Venki

>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de] 
>Sent: Tuesday, February 27, 2007 6:46 AM
>To: Zhang, Rui
>Cc: linux-acpi@vger.kernel.org; Brown, Len; Pallipadi, Venkatesh
>Subject: Re: problem about ACPI processor procfs
>
>On Tue, 2007-02-27 at 17:33 +0800, Zhang, Rui wrote:
>> Hello, list
>> 
>> I met some problems when duplicating ACPI processor procfs 
>interface in sysfs.
>> #cat /proc/acpi/processor/CPU0/limit
>> Active limit:		P0:T0
>> User limit:		P0:T0
>> Thermal limit:	P0,T0
>> 
>> IMO, "Tx" is easy to understand. It indicates the active 
>T-state, T-state set by user and T-state set by thermal (in 
>passive mode).
>> 
>> But what does the "Px" stand for? After reading the code in 
>processor_thermal.c, I don't think user or thermal will change 
>its value.
>> And I don't know if it's still needed when porting to sysfs.
>
>Px are P-states, this is cpufreq.
>Writing to it will probably interfere with /sys/devices/../cpufreq/*.
>x should correspond to the amount of entries in
>/sys/devices/../cpufreq/scaling_available_frequencies.
>
>Can't we just get rid of this? Is there any userspace prog 
>that made use
>of this in /proc and if was it really useful in any way?
>
>   Thomas
>
