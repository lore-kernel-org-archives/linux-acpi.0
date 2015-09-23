From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V3 1/2] ACPI / EC: Fix broken big-endian 64bit platforms
 using 'global_lock'
Date: Wed, 23 Sep 2015 10:15:42 +0100
Message-ID: <56026DBE.3090603@arm.com>
References: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33764 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105AbbIWJPr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Sep 2015 05:15:47 -0400
In-Reply-To: <9b705747a138c96c26faee5218f7b47403195b28.1442305897.git.viresh.kumar@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "arnd@arndb.de" <arnd@arndb.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>



On 15/09/15 09:34, Viresh Kumar wrote:
> global_lock is defined as an unsigned long and accessing only its lower
> 32 bits from sysfs is incorrect, as we need to consider other 32 bits
> for big endian 64 bit systems.
>
> Fix that by making global_lock an u32 instead.
>
> Cc: <stable@vger.kernel.org>  # v4.1+
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> Its marked just for # v4.1+, because arm64 has the first 64 big-endian
> platform with ACPI. And ACPI support for that is mainlined recently
> only (Arnd Bergmann).
>

Just to clarify, we don't support big-endian with ACPI on ARM64.
We mandate use of EFI for ACPI on ARM64 and EFI spec mandates only
little endian.

Regards,
Sudeep
