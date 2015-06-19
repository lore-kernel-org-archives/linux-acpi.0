From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 03/32] ACPICA: Hardware: Enable 64-bit firmware waking vector for selected FACS.
Date: Sat, 20 Jun 2015 01:40:57 +0200
Message-ID: <2633375.qc8AYJl8H9@vostro.rjw.lan>
References: <cover.1434684719.git.lv.zheng@intel.com> <261af597362906597365810a650c8e5c189e86da.1434684719.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46948 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752049AbbFSXO4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2015 19:14:56 -0400
In-Reply-To: <261af597362906597365810a650c8e5c189e86da.1434684719.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

On Friday, June 19, 2015 11:38:28 AM Lv Zheng wrote:
> ACPICA commit 7aa598d711644ab0de5f70ad88f1e2de253115e4
> 
> The root cause of the reported bug might be one of the followings:

Care to describe the bug in the changelog too?  And in a few following
changelogs as well?


> 1. BIOS may favor the 64-bit firmware waking vector address when the
>    version of the FACS is greater than 0 and Linux currently only supports
>    resuming from the real mode, so the 64-bit firmware waking vector has
>    never been set and might be invalid to BIOS while the commit enables
>    higher version FACS.
> 2. BIOS may favor the FACS reported via the "FIRMWARE_CTRL" field in the
>    FADT while the commit doesn't set the firmware waking vector address of
>    the FACS reported by "FIRMWARE_CTRL", it only sets the firware waking
>    vector address of the FACS reported by "X_FIRMWARE_CTRL".


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
