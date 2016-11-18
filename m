From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI / processor / cpufreq: Function return value cleanups
Date: Fri, 18 Nov 2016 13:57:07 +0100
Message-ID: <1975886.qL3AyWerjl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47147 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753184AbcKRMwZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Nov 2016 07:52:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Hi,

Two cleanups related to unused function return values, [1/2] in processor_perflib.c
and [2/2] in cpufreq.c.

Thanks,
Rafael
