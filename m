From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 2/7] irqchip/acpi: Add probing infrastructure for ACPI-based
 irqchips
Date: Tue, 29 Sep 2015 22:42:27 +0800
Message-ID: <560AA353.6040206@linaro.org>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com> <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34704 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433AbbI2Omg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2015 10:42:36 -0400
Received: by padhy16 with SMTP id hy16so8218353pad.1
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2015 07:42:35 -0700 (PDT)
In-Reply-To: <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/28/2015 10:49 PM, Marc Zyngier wrote:
> DT enjoys a rather nice probing infrastructure for irqchips, while
> ACPI is so far stuck into a very distant past.
>
> This patch introduces a declarative API, allowing irqchips to be
> self-contained and be called when a particular entry is matched
> in the MADT table.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
