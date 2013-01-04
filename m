From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/6] ACPI / PM: ACPI power management update
Date: Fri, 04 Jan 2013 22:58:41 +0100
Message-ID: <2311196.icSMDvAsYg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:60473 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310Ab3ADV6z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Jan 2013 16:58:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Huang Ying <ying.huang@intel.com>

Hi All,

There are a few changes of the ACPI power management code I've gathered
over the last few weeks.  Some of them are just cleanups etc., but some
fix (potential) problems and/or add new functionality.

[1/6] - Rework power states changing so that we put devices into D3hot
        (if available) before removing power from them entirely.
[2/6] - Rename __acpi_bus_get_power() (for future use).
[3/6] - Rename state_string() (in bus.c, for future use).
[4/6] - Export the (current) power states of ACPI devices via sysfs.
[5/6] - Move device power management functions from bus.c to device_pm.c.
[6/6] - (Unrelated to the above) Get rid of some ugly #ifdefs in sleep.c.

All of them except for [1/6] have been posted already and no one has had any
comments.

Please review.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
