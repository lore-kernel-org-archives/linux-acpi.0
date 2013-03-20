From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] intel-pstate: Use #defines instead of hard-coded values.
Date: Wed, 20 Mar 2013 20:08:21 +0530
Message-ID: <CAOh2x=n3ENKNBLs6R84D_tZrWNhtEu6ATDyQgqX1nOO0vzDx3g@mail.gmail.com>
References: <1363789270-29579-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f53.google.com ([209.85.212.53]:37398 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab3CTOiW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Mar 2013 10:38:22 -0400
In-Reply-To: <1363789270-29579-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, dirk.j.brandewie@intel.com

On Wed, Mar 20, 2013 at 7:51 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> They are defined in coreboot (MSR_PLATFORM) and the other
> one is already defined in msr-index.h.
>
> Lets use those.
>
> CC: rafael.j.wysocki@intel.com
> CC: dirk.j.brandewie@intel.com
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/include/uapi/asm/msr-index.h | 1 +
>  drivers/cpufreq/intel_pstate.c        | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
