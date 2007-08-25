From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: 2.6.23-rc3-mm1
Date: Fri, 24 Aug 2007 17:38:27 -0700
Message-ID: <653FFBB4508B9042B5D43DC9E18836F5014D956A@scsmsx415.amr.corp.intel.com>
References: <20070822020648.5ea3a612.akpm@linux-foundation.org><46CF695D.1020008@imap.cc> <20070824170702.a2c51084.akpm@linux-foundation.org> <653FFBB4508B9042B5D43DC9E18836F5014D954E@scsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764246AbXHYAio@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <653FFBB4508B9042B5D43DC9E18836F5014D954E@scsmsx415.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>, Thomas Renninger <trenn@suse.de>, Adam Belay <abelay@novell.com>
List-Id: linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org 
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of 
>Pallipadi, Venkatesh
>Sent: Friday, August 24, 2007 5:14 PM
>To: Andrew Morton; Tilman Schmidt
>Cc: linux-kernel@vger.kernel.org; Thomas Gleixner; john 
>stultz; Andi Kleen; Len Brown; linux-acpi@vger.kernel.org; 
>Dave Jones; Thomas Renninger
>Subject: RE: 2.6.23-rc3-mm1
>
> 
>>> - in /var/log/warn:
>>> 
>>> Aug 25 00:44:00 xenon powersaved[5356]: WARNING 
>>(CpufreqManagement:51) No capability cpufreq_control
>>> Aug 25 00:44:00 xenon powersaved[5356]: WARNING 
>>(CpufreqManagement:51) No capability cpufreq_control
>>
>>Dunno, there're some significant-looking cpufreq changes in 
>>there, such as
>>cpufreq-allow-ondemand-and-conservative-cpufreq-governors-to-be
>>-used-as-default.patch.
>>Maybe we went and chose a different governor for you?
>>
>
>This is probably not related to cpufreq changes itself. Looks 
>like it is
>coming due to
>
>>> FATAL: Error inserting processor 
>>(/lib/modules/2.6.23-rc3-mm1-testing/kernel/drivers/acpi/proces
>>sor.ko): Input/output error
>>> WARNING: Error inserting processor 
>>(/lib/modules/2.6.23-rc3-mm1-testing/kernel/drivers/acpi/proces
>>sor.ko): Input/output error
>
>Not sure why this is failing though. Don't recall any significant
>changes in processor.ko recently apart from CPUIDLE stuff.
>

This is indeed related to CPUIDLE.

Tilman: Can you configure CONFIG_CPU_IDLE in your config (under Power
Management option) and double check that the frequency part works after
that.

Andrew: Adam Belay sent a recent patchset on linux-pm and linux-acpi and
one of the patches of that addresses this issue (CPUIDLE: load ACPI
properly when CPUIDLE is disabled). Those patches should come to mm soon
through acpi-test.

Thanks,
Venki
