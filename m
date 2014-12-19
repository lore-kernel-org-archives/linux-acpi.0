From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 0/6] ACPI/EC: Enhance EC driver state machine
Date: Fri, 19 Dec 2014 23:28:41 +0100
Message-ID: <1830437.bnLnyPGhyy@vostro.rjw.lan>
References: <cover.1418966602.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56780 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751488AbaLSWGw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2014 17:06:52 -0500
In-Reply-To: <cover.1418966602.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Friday, December 19, 2014 01:59:19 PM Lv Zheng wrote:
> This patchset fixes several small issues in current EC driver.
> After applying this patchset, we can have all EC IRQ handling code
> collected in advance_transaction() which is the core function of the EC
> driver state machine.
> 
> These fixes are required by the EC GPE raw handler mode switch but not
> dependent on the GPE raw handler mode. So I collect them to form this
> small patchset.
> 
> Lv Zheng (6):
>   ACPI/EC: Cleanup transaction wakeup code
>   ACPI/EC: Add reference counting for query handlers
>   ACPI/EC: Fix returning values in acpi_ec_sync_query()
>   ACPI/EC: Fix a code path that global lock is not held
>   ACPI/EC: Fix issues related to the SCI_EVT handling
>   ACPI/EC: Cleanup QR_EC related code
> 
>  drivers/acpi/ec.c       |  183 +++++++++++++++++++++++------------------------
>  drivers/acpi/internal.h |    1 +
>  2 files changed, 92 insertions(+), 92 deletions(-)

All of this makes sense to me, but I'd rather not push it for 3.19.

I can queue it up for 3.20 after clearing my current 3.19 queue.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
