From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v2 2/3] PCI: hisi: Make the HiSilicon PCIe host
 controller ECAM compliant
Date: Mon, 08 Feb 2016 17:29:40 +0100
Message-ID: <2599997.xBRrI3qHak@wuerfel>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <3532826.pJr5R5Xa4c@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECACF44@lhreml503-mbs>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECACF44@lhreml503-mbs>
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
Cc: "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "liudongdong (C)" <liudongdong3@huawei.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, "bhelgaas@google.com" <bhelgaas@google.com>, zhangjukuo <zhangjukuo@huawei.com>, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>, qiujiang <qiujiang@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 08 February 2016 15:55:35 Gabriele Paoloni wrote:
> > Doesn't this break backwards compatibility?
> 
> Well Hip05/Hip06 SoCs are used into evaluation boards
> For the Estuary project.
> 
> https://github.com/hisilicon/estuary
> 
> As this new driver gets upstream we'll merge this new driver into estuary
> and release a new version of the firmware to support it.

So what happens to folks running the old firmware then?

> > I think you need to use a new compatible string in the firmware
> > if you change the register layout, and then change the driver
> > to support both the old and the new layout.
> 
> You are right, for some reason in this patchset I missed the Documentation
> update that I posted in the previous one, i.e.:
> 
> --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> @@ -23,8 +23,8 @@ Optional properties:
>  Hip05 Example (note that Hip06 is the same except compatible):
>         pcie@0xb0080000 {
>                 compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
> -               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
> -               reg-names = "rc_dbi", "config";
> +               reg = <0 0xb0080000 0 0x10000>, <0x220 0x00100000 0 0x0f00000>;
> +               reg-names = "rc_dbi", "ecam-cfg";
> 

That is not the compatible string, it's an undocumented register set.
You can either define the a new compatible string that gives the "config"
registers a new meaning, or you change the binding to allow two either
a "config" or an "ecam-cfg" register set, and let the driver handle both.

	Arnd
