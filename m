From: Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v6 02/14] irqchip: gic-v3-its: keep the head file include
 in alphabetic order
Date: Wed, 11 Jan 2017 11:20:41 +0100
Message-ID: <ef759a3a-bbdb-2586-24a8-6ad650b07d41@suse.com>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-3-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54218 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762516AbdAKKVK (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Wed, 11 Jan 2017 05:21:10 -0500
In-Reply-To: <1483363905-2806-3-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: huxinwei@huawei.com, Kefeng Wang <wangkefeng.wang@huawei.com>, charles.garcia-tobin@arm.com, Jon Masters <jcm@redhat.com>, yimin@huawei.com, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>



On 02/01/17 14:31, Hanjun Guo wrote:
> The head file is strictly in alphabetic order now, so let's
> be the rule breaker. As acpi_iort.h includes acpi.h so remove
> the duplidate acpi.h inclusion as well.
>

Sounds strange, maybe someting like:
Rearrange header file includes to alphabetic order. As acpi_iort.h...

Regards,
Matthias

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 69b040f..f471939 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -15,14 +15,13 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> -#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>  #include <linux/bitmap.h>
>  #include <linux/cpu.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqdomain.h>
> -#include <linux/acpi_iort.h>
>  #include <linux/log2.h>
>  #include <linux/mm.h>
>  #include <linux/msi.h>
>
