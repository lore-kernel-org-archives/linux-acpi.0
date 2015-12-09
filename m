From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v5 2/5] irqdomain: introduce is_fwnode_irqchip helper
Date: Wed, 9 Dec 2015 10:20:13 +0000
Message-ID: <20151209102013.6193b3ac@why.wild-wind.fr.eu.org>
References: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1449625686-5594-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449625686-5594-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 8 Dec 2015 17:48:03 -0800
Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:

> Since there will be several places checking if fwnode.type
> is equal FWNODE_IRQCHIP, this patch adds a convenient function
> for this purpose.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
