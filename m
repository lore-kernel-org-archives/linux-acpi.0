From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size()
 and early_acpi_os_unmap_memory() from Linux kernel
Date: Sun, 8 Jan 2017 01:22:55 +0100
Message-ID: <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic> <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
 <20170108000702.wrov5ajeou2y3tuy@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34477 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbdAHAW4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jan 2017 19:22:56 -0500
In-Reply-To: <20170108000702.wrov5ajeou2y3tuy@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Sun, Jan 8, 2017 at 1:07 AM, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Jan 08, 2017 at 12:30:27AM +0100, Rafael J. Wysocki wrote:
>> Please check if this helps:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=696c7f8e0373026e8bfb29b2d9ff2d0a92059d4d
>
> Unfortunately no, still same early freeze. :-\
>
> The splat happens when booting 6b11d1d67713 directly, 4.10-rc2 doesn't
> splat but freezes simply very early during boot.

Is an IVRS table actually present on this machine?

Thanks,
Rafael
