From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 03/32] ACPICA: Hardware: Enable 64-bit firmware waking
 vector for selected FACS.
Date: Tue, 23 Jun 2015 17:20:51 +0200
Message-ID: <CAJZ5v0gfdfJF_-wK26wjxY=ai+QoUtS3ZpLT4ORX-P_wPQiA-g@mail.gmail.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
	<261af597362906597365810a650c8e5c189e86da.1434684719.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38305 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328AbbFWPUx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2015 11:20:53 -0400
In-Reply-To: <261af597362906597365810a650c8e5c189e86da.1434684719.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bob Moore <robert.moore@intel.com>

Hi Lv,

On Fri, Jun 19, 2015 at 5:38 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> ACPICA commit 7aa598d711644ab0de5f70ad88f1e2de253115e4
>
> The root cause of the reported bug might be one of the followings:
> 1. BIOS may favor the 64-bit firmware waking vector address when the
>    version of the FACS is greater than 0 and Linux currently only supports
>    resuming from the real mode, so the 64-bit firmware waking vector has
>    never been set and might be invalid to BIOS while the commit enables
>    higher version FACS.
> 2. BIOS may favor the FACS reported via the "FIRMWARE_CTRL" field in the
>    FADT while the commit doesn't set the firmware waking vector address of

Can you please tell me which commit this is about?

>    the FACS reported by "FIRMWARE_CTRL", it only sets the firware waking
>    vector address of the FACS reported by "X_FIRMWARE_CTRL".

Thanks,
Rafael
