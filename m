From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Tue, 10 Jan 2017 10:41:22 +0100
Message-ID: <20170110094122.hpg4sluemkzomeiw@pd.tnic>
References: <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
 <20170109235211.yetponvbexvalkir@pd.tnic>
 <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48941 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbdAJJl0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Jan 2017 04:41:26 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gRYcC5fJZF207iyehvPR9_2zqprSvWHA_Qt93W9njqAw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Jan 10, 2017 at 02:27:16AM +0100, Rafael J. Wysocki wrote:
> Well, if the https://patchwork.kernel.org/patch/9504277/ patch from Lv
> worked, the attached one should work too (please test), but it can be
> justified in a slightly more convincing way.

No workie:

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 57fb5f4..acb6118 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -378,7 +378,11 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
 static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
        if (!map->refcount) {
-               synchronize_rcu_expedited();
+               if (acpi_os_initialized) {
+                       pr_err("%s: acpi_os_initialized\n", __func__);
+                       synchronize_rcu_expedited();
+               }
+
                acpi_unmap(map->phys, map->virt);
                kfree(map);
        }

The pr_err() gets issued before the box hangs.

Lv's version which set the bool in acpi_os_map_generic_address() did
work though.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
