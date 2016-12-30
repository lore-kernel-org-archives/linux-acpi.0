From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 02/14] irqchip: gic-v3-its: keep the head file include
 in alphabetic order
Date: Fri, 30 Dec 2016 16:56:43 +0800
Message-ID: <5866214B.8090803@hisilicon.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-3-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:35739 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbcL3JGw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2016 04:06:52 -0500
In-Reply-To: <1482384922-21507-3-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, jcm@redhat.com, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> The head file is strictly in alphabetic order now, so let's
> be the rule breaker. As acpi_iort.h includes acpi.h so remove
> the duplidate acpi.h inclusion as well.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 69b040f..f471939 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -15,14 +15,13 @@
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>   #include <linux/bitmap.h>
>   #include <linux/cpu.h>
>   #include <linux/delay.h>
>   #include <linux/dma-iommu.h>
>   #include <linux/interrupt.h>
>   #include <linux/irqdomain.h>
> -#include <linux/acpi_iort.h>
>   #include <linux/log2.h>
>   #include <linux/mm.h>
>   #include <linux/msi.h>
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>

