From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG][2.6.30] Niced processes do not raise CPU frequency with ondemand
Date: Fri, 12 Jun 2009 19:25:37 +0200
Message-ID: <200906121925.38693.elendil@planet.nl>
References: <200906121844.02004.elendil@planet.nl> <1244825317.4534.1342.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:50336 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750749AbZFLRZh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Jun 2009 13:25:37 -0400
In-Reply-To: <1244825317.4534.1342.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Thanks for the quick reply Venki.

On Friday 12 June 2009, Pallipadi, Venkatesh wrote:
> What does ignore_nice under cpufreq/ondemand say?

Right, that's 1 (was not aware that existed :-P)
And changing it to 0 solves the problem.

Next question is: how and why does it get set?
As userland has not changed (AFAIK), my first suspect remains the kernel.

# grep . /sys/devices/system/cpu/cpu*/cpufreq/ondemand/*
/sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice_load:1
/sys/devices/system/cpu/cpu0/cpufreq/ondemand/powersave_bias:0
/sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate:80000
/sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate_max:40000000
/sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate_min:40000
/sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold:90
/sys/devices/system/cpu/cpu1/cpufreq/ondemand/ignore_nice_load:1
/sys/devices/system/cpu/cpu1/cpufreq/ondemand/powersave_bias:0
/sys/devices/system/cpu/cpu1/cpufreq/ondemand/sampling_rate:80000
/sys/devices/system/cpu/cpu1/cpufreq/ondemand/sampling_rate_max:40000000
/sys/devices/system/cpu/cpu1/cpufreq/ondemand/sampling_rate_min:40000
/sys/devices/system/cpu/cpu1/cpufreq/ondemand/up_threshold:90
