From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v7 00/15] ACPI platform MSI support and its example mbigen
Date: Sat, 14 Jan 2017 12:30:52 +0800
Message-ID: <5879A97C.50604@huawei.com>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
 <5878E02E.5080602@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5878E02E.5080602@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Xu <xuwei5@hisilicon.com>, Hanjun Guo <hanjun.guo@linaro.org>, Marc
 Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Matthias Brugger <mbrugger@suse.com>, yimin@huawei.com, Jon Masters <jcm@redhat.com>, linuxarm@huawei.com, linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Agustin Vega-Frias <agustinv@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Hi Wei,

On 2017/1/13 22:11, Wei Xu wrote:
> Hi Hanjun,
>
> On 2017/1/11 15:06, Hanjun Guo wrote:
>> With platform msi support landed in the kernel, and the introduction
>> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
>> is ready, this patch set add few patches to enable the ACPI platform
>> msi support.
>>
>> For platform device connecting to ITS on arm platform, we have IORT
>> table with the named componant node to describe the mappings of paltform
>> device and ITS, so we can retrieve the dev id and find its parent
>> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
>>
>> v6 -> v7: 
>> 	- Introduce iort_node_map_platform_id() to retrieve the
>> 	  dev id for both NC (named component) -> ITS/SMMU and
>> 	  NC -> SMMU -> ITS cases, suggested by Lorenzo;
>>
>> 	- Reorder the patches and rewrite some commit message;
>>
>> 	- Remove the test tags because it has major changes
>> 	  to retrieve the dev id, Sinan, Majun, Xinwei, could
>> 	  you please test them again on your platform?
>>
>> 	- rebased on top of 4.10-rc3 and Lorenzo's patch
>>           https://patchwork.kernel.org/patch/9507041/
>>
>> 	- Tested against Agustin's patch [1-2/3] "[PATCH V9 0/3] irqchip: qcom:
>>           Add IRQ combiner driver"
> I tested this patch set on the Hisilicon D05 board with these patches:
>
>   [1] Agustin's V9 IRQ combiner driver patch set
>       https://patchwork.kernel.org/patch/9474751/
>
>   [2] Lorenzo's v2 iort_node_get_id fix patch
>       https://patchwork.kernel.org/patch/9507041/
>
> The branch is at https://github.com/hisilicon/linux-hisi/tree/topic-acpi-mbigen.
>
> The integrated XGE, SAS and PCIe controller works fine.
> So with this patch set:
>
> Tested-by: Wei Xu <xuwei5@hisilicon.com>

I didn't test PCIe it's good to know it's working, thanks for testing
and let me know.

Hanjun
