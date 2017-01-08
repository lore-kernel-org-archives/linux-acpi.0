From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Sun, 8 Jan 2017 01:37:30 +0100
Message-ID: <20170108003730.hlcqkhdxtah65z66@pd.tnic>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic>
 <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
 <20170108000702.wrov5ajeou2y3tuy@pd.tnic>
 <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:35368 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933014AbdAHAhi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 7 Jan 2017 19:37:38 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Sun, Jan 08, 2017 at 01:22:55AM +0100, Rafael J. Wysocki wrote:
> Is an IVRS table actually present on this machine?

Like this?

[    0.000000] ACPI: IVRS 0x000000009CFD6000 0000D0 (v02 AMD    AGESA    00000001 AMD  00000000)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
