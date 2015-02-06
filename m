From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/5] ACPI / EC: Add reference counting for requests and cleans up the grace periods support.
Date: Fri, 06 Feb 2015 02:26:30 +0100
Message-ID: <1711204.9KEDEeQMDo@vostro.rjw.lan>
References: <20141119121615.GA2514@node.dhcp.inet.fi> <cover.1423183647.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51825 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751093AbbBFBDd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 20:03:33 -0500
In-Reply-To: <cover.1423183647.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday, February 06, 2015 08:57:37 AM Lv Zheng wrote:
> This patchset contains 3 cleanups related to the EC driver:
> 1. Command flushing (command grace period)
>    This patchset flushes EC commands before suspending/resuming, so that
>    there won't be timeout for the incomplete commands after resuming.
> 2. Query flushing (query grace period)
>    This patchset flushes EC event queries before suspending/resuming, so
>    that there won't be broken events remained in the firmware queue.
> 3. Command storming prevention
>    This patchset corrects command storming prevention logic because of
>    the GPE raw handler mode.
> The request reference count debugging messages can be used to detect broken
> EC transactions. It should always drop to 1 when the driver is idle during
> the runtime.
> 
> Note that after flushing before suspending, EC GPE is still enabled to keep
> the old behavior.
> 
> Lv Zheng (5):
>   ACPI/EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag.
>   ACPI/EC: Add command flushing support.
>   ACPI/EC: Refine command storm prevention support.
>   ACPI/EC: Add query flushing support.
>   ACPI/EC: Add GPE reference counting debugging messages.
> 
>  drivers/acpi/ec.c       |  295 ++++++++++++++++++++++++++++++++++++++++-------
>  drivers/acpi/internal.h |    1 +
>  2 files changed, 254 insertions(+), 42 deletions(-)

So this is on top of the EC patches you sent previously, right?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
