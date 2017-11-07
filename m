From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v10 9/9] MANTAINERS: Add maintainer for HiSilicon LPC
 driver
Date: Mon, 6 Nov 2017 18:21:20 -0600
Message-ID: <20171107002120.GB9538@bhelgaas-glaptop.roam.corp.google.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-10-git-send-email-gabriele.paoloni@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1509120687-7352-10-git-send-email-gabriele.paoloni@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: mark.rutland@arm.com, minyard@acm.org, lorenzo.pieralisi@arm.com, linux-acpi@vger.kernel.org, arnd@arndb.de, rafael@kernel.org, linux-pci@vger.kernel.org, catalin.marinas@arm.com, john.garry@huawei.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, linuxarm@huawei.com, olof@lixom.net, robh+dt@kernel.org, benh@kernel.crashing.org, bhelgaas@google.com, frowand.list@gmail.com, brian.starkey@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

s/MANTAINERS/MAINTAINERS/

On Fri, Oct 27, 2017 at 05:11:27PM +0100, Gabriele Paoloni wrote:
> Added maintainer for drivers/bus/hisi_lpc.c
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f66488d..b49d4c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6130,6 +6130,13 @@ F:	include/uapi/linux/if_hippi.h
>  F:	net/802/hippi.c
>  F:	drivers/net/hippi/
>  
> +HISILICON LPC BUS DRIVER
> +L:	linuxarm@huawei.com
> +W:	http://www.hisilicon.com
> +S:	Maintained
> +F:	drivers/bus/hisi_lpc.c
> +F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt

Does this really count as a "maintainer" since it's only a mailing
list, not a real person?  I personally prefer a specific person
because there's no accountability with a mailing list.

> +
>  HISILICON NETWORK SUBSYSTEM DRIVER
>  M:	Yisen Zhuang <yisen.zhuang@huawei.com>
>  M:	Salil Mehta <salil.mehta@huawei.com>
> -- 
> 2.7.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
