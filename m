From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.23-rc3-mm1
Date: Fri, 24 Aug 2007 17:13:37 -0700
Message-ID: <653FFBB4508B9042B5D43DC9E18836F5014D954E@scsmsx415.amr.corp.intel.com>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org><46CF695D.1020008@imap.cc> <20070824170702.a2c51084.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11688 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758637AbXHYANk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Aug 2007 20:13:40 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20070824170702.a2c51084.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>, Thomas Renninger <trenn@suse.de>

 
>> - in /var/log/warn:
>> 
>> Aug 25 00:44:00 xenon powersaved[5356]: WARNING 
>(CpufreqManagement:51) No capability cpufreq_control
>> Aug 25 00:44:00 xenon powersaved[5356]: WARNING 
>(CpufreqManagement:51) No capability cpufreq_control
>
>Dunno, there're some significant-looking cpufreq changes in 
>there, such as
>cpufreq-allow-ondemand-and-conservative-cpufreq-governors-to-be
>-used-as-default.patch.
>Maybe we went and chose a different governor for you?
>

This is probably not related to cpufreq changes itself. Looks like it is
coming due to

>> FATAL: Error inserting processor 
>(/lib/modules/2.6.23-rc3-mm1-testing/kernel/drivers/acpi/proces
>sor.ko): Input/output error
>> WARNING: Error inserting processor 
>(/lib/modules/2.6.23-rc3-mm1-testing/kernel/drivers/acpi/proces
>sor.ko): Input/output error

Not sure why this is failing though. Don't recall any significant
changes in processor.ko recently apart from CPUIDLE stuff.

Thanks,
Venki
