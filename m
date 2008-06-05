From: "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: bug? acpi p-state + ondemand keeps dropping max freq
Date: Thu, 05 Jun 2008 15:30:56 -0700
Message-ID: <48486920.4040006@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63004 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754570AbYFEWcl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Jun 2008 18:32:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, cpufreq@lists.linux.org.uk, Dave Jones <davej@codemonkey.org.uk>


I've consistently experienced the following bizarre problem since 2.6.20, all the
way up to 2.6.25.3 (regressed yesterday and each of these kernels exposes this
behaviour):

/sys/devices/system/cpu/cpu0/cpufreq # grep . *
affected_cpus:0
cpuinfo_cur_freq:800000
cpuinfo_max_freq:1866000
cpuinfo_min_freq:800000
scaling_available_frequencies:1866000 1600000 1333000 1066000 800000
scaling_available_governors:ondemand performance
scaling_cur_freq:800000
scaling_driver:acpi-cpufreq
scaling_governor:ondemand
scaling_max_freq:800000
scaling_min_freq:800000



Notice that scaling_mx_freq dropped down to the lowest possible value and as such
my CPU is only working at 800MHz. At boot time this field properly displays
1866MHz and everything works OK. After a certain period (?) this value drops down
and I cannot manually elevate it back to the normal level:

# echo 1866000 > scaling_max_freq ; cat scaling_max_freq
800000
# echo 1866000 > scaling_max_freq ; cat scaling_max_freq
800000


This renders my Dothan to utterly poor speeds. (standard T43)

performance cpufreq governor makes no difference - I still can't change the
frequency upper/lower values.

Auke
