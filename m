From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2 V2] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Thu, 27 Jun 2013 10:54:12 +0530
Message-ID: <CAKohpokrU4LYGeL_oai+F1irHgk4y+KmO+71_MGVNOhEG6_QDw@mail.gmail.com>
References: <1372250304-20975-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:39514 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab3F0FYN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2013 01:24:13 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so335106oag.13
        for <linux-acpi@vger.kernel.org>; Wed, 26 Jun 2013 22:24:12 -0700 (PDT)
In-Reply-To: <1372250304-20975-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On 26 June 2013 18:08, Lan Tianyu <tianyu.lan@intel.com> wrote:
> diff --git a/Documentation/cpu-freq/acpi-cpufreq.txt b/Documentation/cpu-freq/acpi-cpufreq.txt
> new file mode 100644
> index 0000000..9c59d09
> --- /dev/null
> +++ b/Documentation/cpu-freq/acpi-cpufreq.txt
> @@ -0,0 +1,7 @@
> +Sysfs interface
> +---------------------------
> +(Interface locates in the directory /sys/devices/system/cpu/cpuN/cpufreq)
> +
> +freqdomain_cpus :               List of Online + Offline CPUs in same CPU dependency
> +                                domain.
> +

Apart from the comments from Rafael, this must be described a bit
more. We must write here how is it different than related_cpus.

Write: freqdomain_cpus are the list of cpus (online+offline) that share
same clock/freq domain at hardware level. This information might
be hidden from cpufreq core and so related_cpus can have different
value compared to this. This is not used by kernel but userspace
DVFS controllers to get better power/performance values for platforms
using acpi-cpufreq.c driver.
