From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/7] ACPICA 20130117 Release
Date: Sat, 26 Jan 2013 15:07:54 +0100
Message-ID: <1794343.GIdEXKiY5c@vostro.rjw.lan>
References: <cover.1358825277.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:56468 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab3AZOBt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Jan 2013 09:01:49 -0500
In-Reply-To: <cover.1358825277.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Friday, January 25, 2013 01:38:19 PM Lv Zheng wrote:
> The 20130117 ACPICA linuxized patches are based on the pm/linux-next
> branch.
> This patch set has passed 0-day kernel build/boot tests.
> 
> Bob Moore (6):
>   ACPICA: Update ACPICA copyrights to 2013
>   ACPICA: AcpiGetSleepTypeData: Allow \_Sx to return either 1 or 2
>     integers
>   ACPICA: iASL/Disassembler: Add option to ignore NOOP
>     opcodes/operators
>   ACPICA: Remove some extraneous newlines in ACPI_ERROR type calls
>   ACPICA: Update predefined info table for _MLS method
>   ACPICA: Update version to 20130117
> 
> Lv Zheng (1):
>   ACPICA: Update predefined info table
> 

Applied to linux-pm.git/linux-next, thanks Lv!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
