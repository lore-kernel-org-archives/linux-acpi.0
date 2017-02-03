From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH V12 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Fri, 3 Feb 2017 18:31:48 +0800
Message-ID: <58945C14.2090009@huawei.com>
References: <1486077839-25547-1-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486077839-25547-1-git-send-email-agustinv@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: harba@codeaurora.org, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, jcm@redhat.com, timur@codeaurora.org, msalter@redhat.com, astone@redhat.com, andy.shevchenko@gmail.com, mlangsdo@redhat.com, cov@codeaurora.org, agross@codeaurora.org, ahs3@redhat.com, charles.garcia-tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

On 2017/2/3 7:23, Agustin Vega-Frias wrote:
> Add support for IRQ combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
>
> The first patch prevents the ACPI core from attempting to map IRQ resources
> with a valid ResourceSource as GSIs.
>
> The second patch adds support for ResourceSource/IRQ domain mapping and
> fixes IRQ probe deferral by allowing platform_device IRQ resources to be
> re-initialized from the corresponding ACPI IRQ resource.
>
> Both changes described above are conditional on the ACPI_GENERIC_GSI config.
>
> The third patch takes advantage of the new capabilities to implement
> the driver for the IRQ combiners.
>
> Tested on top of v4.10-rc6.
>
> Changes V11 -> V12:
> * Remove probe table, add that optimization later.
> * Fix some minor style issues.

For patch [1-2/3], I tested on x86 and IA64 machine, didn't see
regressions in dmesg, and tested them on Hisilicon D03 (ARM64 with
mbigen irqchip which needs this mechanism) , it works fine.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
