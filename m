From: Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: Re: [PATCH V9 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Tue, 03 Jan 2017 10:19:22 -0500
Message-ID: <16e3b40407e8072dd5b15bf7e65afb18@codeaurora.org>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: harba@codeaurora.org, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, jcm@redhat.com, timur@codeaurora.org, msalter@redhat.com, guohanjun@huawei.com, astone@redhat.com, mlangsdo@redhat.com, cov@codeaurora.org, agross@codeaurora.org, ahs3@redhat.com, charles.garcia-tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

Hi,

Is there any more feedback on this beyond Lorenzo's suggestion to drop
the conditional check on the first patch?
How can we move forward on this series?

Thanks.

On 2016-12-14 17:10, Agustin Vega-Frias wrote:
> Add support for IRQ combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
> 
> The first patch prevents the ACPI core from attempting to map IRQ 
> resources
> with a valid ResourceSource as GSIs.
> 
> The second patch adds support for ResourceSource/IRQ domain mapping and
> fixes IRQ probe deferral by allowing platform_device IRQ resources to 
> be
> re-initialized from the corresponding ACPI IRQ resource.
> 
> Both changes described above are conditional on the ACPI_GENERIC_GSI 
> config.
> 
> The third patch takes advantage of the new capabilities to implement
> the driver for the IRQ combiners.
> 
> Tested on top of v4.9.
> 
> Changes V8 -> V9:
> * Do not attempt the mapping for non-GSI IRQs during bus scan.
> * Make some public APIs private to drivers/acpi/irq.c since they are no
>   longer used on other modules.
> 
> Changes V7 -> V8:
> * Reorder patches to allow all new code to be under drivers/acpi/irq.c.
> * Change acpi_irq_get implementation to be more similar to of_irq_get
>   to improve maintainability.
> 
> Agustin Vega-Frias (3):
>   ACPI: Generic GSI: Do not attempt to map non-GSI IRQs during bus scan
>   ACPI: Add support for ResourceSource/IRQ domain mapping
>   irqchip: qcom: Add IRQ combiner driver
> 
>  drivers/acpi/Makefile               |   2 +-
>  drivers/acpi/gsi.c                  |  98 -----------
>  drivers/acpi/irq.c                  | 280 
> +++++++++++++++++++++++++++++++
>  drivers/acpi/resource.c             |  17 +-
>  drivers/base/platform.c             |   9 +-
>  drivers/irqchip/Kconfig             |   9 +
>  drivers/irqchip/Makefile            |   1 +
>  drivers/irqchip/qcom-irq-combiner.c | 322 
> ++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h                |  10 ++
>  9 files changed, 647 insertions(+), 101 deletions(-)
>  delete mode 100644 drivers/acpi/gsi.c
>  create mode 100644 drivers/acpi/irq.c
>  create mode 100644 drivers/irqchip/qcom-irq-combiner.c
> 
> --
> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a
> Linux Foundation Collaborative Project.

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
