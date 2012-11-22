From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/15] ACPICA 20121114 Release
Date: Thu, 22 Nov 2012 01:15:18 +0100
Message-ID: <5187076.AaPnTPlBdI@vostro.rjw.lan>
References: <cover.1353491652.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:60339 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939Ab2KVS4u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Nov 2012 13:56:50 -0500
In-Reply-To: <cover.1353491652.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

On Wednesday, November 21, 2012 06:06:45 PM Lv Zheng wrote:
> The 20121114 ACPICA linuxized patches are based on the pm/linux-next branch.
> Please review though the patches have passed the basic build & boot tests.
> 
> Bob Moore (6):
>   ACPICA: Performance: Remove function tracing from critical allocation
>     functions.
>   ACPICA: Debugger: Major update for the Disassemble<method> command.
>   ACPICA: Disassembler: Add new ACPI 5 interrupt sharing flags.
>   ACPICA: Add macros to extract flag bits from resource descriptors.
>   ACPICA: AcpiGetObjectInfo: optimize exit for mutex failure.
>   ACPICA: Update version to 20121114.
> 
> Chao Guan (1):
>   ACPICA: Performance enhancement for ACPI package objects.
> 
> Jesper Juhl (1):
>   ACPICA: Fix possible memory leak.
> 
> Lv Zheng (7):
>   ACPICA: Fixes unmerged (dis)assember divergences.
>   ACPICA: Fixes comments caused divergences.
>   ACPICA: Fixes indent caused divergences.
>   ACPICA: Fixes code maintenance divergences.
>   ACPICA: Fixes call depth check caused divergences.
>   ACPICA: Enhance the ACPI_GETx and ACPI_SETx macros.
>   ACPICA: Resource Manager: update template walking with
>     ACPI_NEXT_RESOURCE.

Whole series applied to linux-pm.git/linux-next as v3.8 material.

Thanks Lv!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
