From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 1/7] acpi: Add early device probing infrastructure
Date: Tue, 29 Sep 2015 22:41:18 +0800
Message-ID: <560AA30E.8030008@linaro.org>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com> <1443451758-22717-2-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443451758-22717-2-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 09/28/2015 10:49 PM, Marc Zyngier wrote:
> IRQ controllers and timers are the two types of device the kernel
> requires before being able to use the device driver model.
>
> ACPI so far lacks a proper probing infrastructure similar to the one
> we have with DT, where we're able to declare IRQ chips and
> clocksources inside the driver code, and let the core code pick it up
> and call us back on a match. This leads to all kind of really ugly
> hacks all over the arm64 code and even in the ACPI layer.
>
> In order to allow some basic probing based on the ACPI tables,
> introduce "struct acpi_probe_entry" which contains just enough
> data and callbacks to match a table, an optional subtable, and
> call a probe function. A driver can, at build time, register itself
> and expect being called if the right entry exists in the ACPI
> table.
>
> A acpi_probe_device_table() is provided, taking an identifier for
> a set of acpi_prove_entries, and iterating over the registered
> entries.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
