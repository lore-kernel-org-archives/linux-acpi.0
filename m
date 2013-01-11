From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] ACPICA: Missing patches for 20121220 release.
Date: Fri, 11 Jan 2013 13:20:50 +0100
Message-ID: <8440009.ekzx4iWl3E@vostro.rjw.lan>
References: <cover.1356668530.git.lv.zheng@intel.com> <cover.1357982088.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:37714 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409Ab3AKMPE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2013 07:15:04 -0500
In-Reply-To: <cover.1357982088.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Saturday, January 12, 2013 11:28:50 PM Lv Zheng wrote:
> This patch set is based on the ACPICA 20121220 release currently can be
> found in the linux-next branch of linux-pm tree.
> This patch set has stayed in the acpica-201212 branch of the ACPICA
> release test tree for one days.
> The source code differences between Linux and ACPICA can be summarized as
> follows:
> 1. 1963 Lines (70.0 Kbytes) before applying the patch set;
> 2. 1796 Lines (64.8 Kbytes) after applying the patch set.
> 
> Please review.
> 
> Bob Moore (1):
>   ACPICA: Source restructuring: split large files into 8 new files.
> 
> Lv Zheng (2):
>   ACPICA: Cleanup table handler naming conflicts.
>   ACPICA: Add new statistics interface.

OK, applied.

I took [1/3] directly from my mailbox, because it looks like vger didn't allow
it to go to the list.

Please check the ACPICA material in the linux-next branch of my tree and if
there's anything more you'd like to go into v3.9, please let me know.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
