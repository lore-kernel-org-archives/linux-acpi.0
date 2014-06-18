From: Julian Wollrath <jwollrath@web.de>
Subject: Re: New ACPI warnings with v3.16.0-rc1
Date: Thu, 19 Jun 2014 01:38:30 +0200
Message-ID: <20140619013830.265e74cd@saldaea>
References: <20140618235004.25295650@saldaea>
	<8028563.JQMq23p6sJ@vostro.rjw.lan>
	<1403132844.30783.33.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:60484 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbaFRXij (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jun 2014 19:38:39 -0400
In-Reply-To: <1403132844.30783.33.camel@rzhang1-toshiba>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

Hi,

> BTW, there is indeed one new driver that invokes
> acpi_check_resource_conflict() between 3.15 and 3.16-rc1.
> could you please check if CONFIG_SENSORS_NCT6683 is set in your
> config? If yes, does the warning messages go away if
> CONFIG_SENSORS_NCT6683=n?
CONFIG_SENSORS_NCT6683 is not set.

I just look into the dmesg output again and saw the following:
[   14.560580] lpc_ich: Resource conflict(s) found affecting gpio_ich

Then I checked the git log and stumbled upon commit 62cf2cdb99c7e (mfd:
lpc_ich: Enable GPIO for Panther Point). Since I have a Panther Point
chipset, that commit is possibly to blame, since now that driver can
also handle Panther Point. The only problem is, that CONFIG_LPC_ICH
gets auto-enabled by having CONFIG_ITCO_WDT (Intel Watchdog support)
enabled and it can not be disabled without disabling the watchdog
support.

> please attach the acpidump output.
Done.


Cheers,
Julian
