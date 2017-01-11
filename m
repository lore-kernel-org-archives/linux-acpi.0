From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Wed, 11 Jan 2017 10:42:03 +0100
Message-ID: <20170111094203.6of3digwcdcdpith@pd.tnic>
References: <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
 <20170109235211.yetponvbexvalkir@pd.tnic>
 <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com>
 <20170110094122.hpg4sluemkzomeiw@pd.tnic>
 <CAJZ5v0gEyaqRvYA79bFrkCcw3Yto3WHbh=AdeG3s22_AjkR5iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:38138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdAKJmr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Jan 2017 04:42:47 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gEyaqRvYA79bFrkCcw3Yto3WHbh=AdeG3s22_AjkR5iA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Jan 11, 2017 at 04:42:16AM +0100, Rafael J. Wysocki wrote:
> Let's try the attached one.

Works, thanks. Lemme give you the tags :)

Reported-and-tested-by: Borislav Petkov <bp@suse.de>
Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel")
Link: https://lkml.kernel.org/r/4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com

> BTW, I'm going to travel to the LCA starting tomorrow, so I guess I
> will be a bit unresponsive during the next few days.

Sure, we have time. Have a safe trip!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
