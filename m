From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 6/7] clocksource/arm_arch_timer: Convert to ACPI
 probing
Date: Tue, 29 Sep 2015 11:26:50 +0100
Message-ID: <20150929102650.GE30504@e104818-lin.cambridge.arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-7-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54436 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933838AbbI2K0z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Sep 2015 06:26:55 -0400
Content-Disposition: inline
In-Reply-To: <1443451758-22717-7-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org

On Mon, Sep 28, 2015 at 03:49:17PM +0100, Marc Zyngier wrote:
> It is now absolutely trivial to convert the arch timer driver to
> use ACPI probing, just like its DT counterpart.
> 
> Let's enjoy another crapectomy.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
