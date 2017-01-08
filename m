From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Sun, 8 Jan 2017 01:07:02 +0100
Message-ID: <20170108000702.wrov5ajeou2y3tuy@pd.tnic>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic>
 <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48281 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbdAHAHG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 7 Jan 2017 19:07:06 -0500
Content-Disposition: inline
In-Reply-To: <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Sun, Jan 08, 2017 at 12:30:27AM +0100, Rafael J. Wysocki wrote:
> Please check if this helps:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=696c7f8e0373026e8bfb29b2d9ff2d0a92059d4d

Unfortunately no, still same early freeze. :-\

The splat happens when booting 6b11d1d67713 directly, 4.10-rc2 doesn't
splat but freezes simply very early during boot.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
