From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 03/32] ACPICA: Hardware: Enable 64-bit firmware waking vector for selected FACS.
Date: Wed, 24 Jun 2015 02:30:11 +0200
Message-ID: <2005221.p5Qv0lW5dz@vostro.rjw.lan>
References: <cover.1434684719.git.lv.zheng@intel.com> <261af597362906597365810a650c8e5c189e86da.1434684719.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43133 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755009AbbFXAEE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2015 20:04:04 -0400
In-Reply-To: <261af597362906597365810a650c8e5c189e86da.1434684719.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

On Friday, June 19, 2015 11:38:28 AM Lv Zheng wrote:
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
>    the FACS reported by "FIRMWARE_CTRL", it only sets the firware waking
>    vector address of the FACS reported by "X_FIRMWARE_CTRL".
> 
> This patch excludes the cases that can trigger the bugs caused by the root
> cause 1.
> 
> ACPI specification says:
> A. 32-bit FACS address (FIRMWARE_CTRL field in FADT):
>    Physical memory address of the FACS, where OSPM and firmware exchange
>    control information.
>    If the X_FIRMWARE_CTRL field contains a non zero value then this field
>    must be zero.
>    A zero value indicates that no FACS is specified by this field.
> B. 64-bit FACS address (X_FIRMWARE_CTRL field in FADT):
>    64bit physical memory address of the FACS.
>    This field is used when the physical address of the FACS is above 4GB.
>    If the FIRMWARE_CTRL field contains a non zero value then this field
>    must be zero.
>    A zero value indicates that no FACS is specified by this field.
> Thus the 32bit and 64bit firmware waking vector should indicate completely
> different resuming environment - real mode (1MB addressable) and non real
> mode (4GB+ addressable) and currently Linux only supports resuming from
> real mode.
> 
> This patch enables 64-bit firmware waking vector for selected FACS via
> acpi_set_firmware_waking_vector() so that it's up to OSPMs to determine which
> resuming mode should be used by BIOS and ACPICA changes won't trigger the
> bugs caused by the root cause 1. For example, Linux can pass
> physical_address64=0 as the parameter of acpi_set_firmware_waking_vector() to
> indicate no 64bit waking vector support. Lv Zheng.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=74021
> Link: https://github.com/acpica/acpica/commit/7aa598d7
> Reported-and-tested-by: Oswald Buddenhagen <ossi@kde.org>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>

So what the patch does is to replace two functions, acpi_set_firmware_waking_vector()
taking one u32 argument and acpi_set_firmware_waking_vector64() taking one u64
argument, with a modified acpi_set_firmware_waking_vector() taking two arguments
of type acpi_physical_address.  And it breaks compliation when applied to Linux
as is AFAICS, doesn't it?

I guess the point is to allow the OS to set firmware_waking_vector *and* clear
xfirmware_waking_vector at the same time (by passing 0 as the second argument
of the function).  And that helps to address the issue when xfirmware_waking_vector
has a random value to start with, we don't clear it and the BIOS thinks it is OK
to use it, right?

If that's the case, this patch should be combined with [4/32] and the signal-to-noise
ratio of [4/32] needs to be increased quite a bit.

Rafael

