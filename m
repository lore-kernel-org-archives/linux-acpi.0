From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] arm64: topology: Avoid checking numa mask for scheduler
 MC selection
Date: Wed, 6 Jun 2018 15:44:44 +0100
Message-ID: <20180606144444.GB8461@e105550-lin.cambridge.arm.com>
References: <20180605190837.493505-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180605190837.493505-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep.Holla@arm.com, Will.Deacon@arm.com, Catalin.Marinas@arm.com, Robin.Murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linux-acpi@vger.kernel.org, ard.biesheuvel@linaro.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 05, 2018 at 02:08:37PM -0500, Jeremy Linton wrote:
> The numa mask subset check has problems if !CONFIG_NUMA, over hotplug
> operations or during early boot. Lets disable the NUMA siblings checks
> for the time being, as NUMA in socket machines have LLC's that will
> assure that the scheduler topology isn't "borken".

Could we add an explanation why the numa node mask check is needed in
the first place?

IIUC, we have the check in case the LLC is shared across numa nodes as
this would cause core_siblings > cpumask_of_node() which breaks the
scheduler topology.

While sharing LLC across numa nodes seems quite unusual, I think it is
allowed by ACPI. Those systems might already be broken before, so might
not change anything. It is just worth noting why the check should be
added back later.

Morten
