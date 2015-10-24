From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH V1 10/10] acpi, gicv3, its: Use MADT ITS subtable to do
 PCI/MSI domain initialization.
Date: Sat, 24 Oct 2015 15:58:17 +0200
Message-ID: <562B8E79.6010701@linaro.org>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
 <1444917919-21152-11-git-send-email-tn@semihalf.com>
 <562B5B6E.2000305@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34123 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbbJXN6V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Oct 2015 09:58:21 -0400
Received: by lfaz124 with SMTP id z124so109149348lfa.1
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2015 06:58:20 -0700 (PDT)
In-Reply-To: <562B5B6E.2000305@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com
Cc: will.deacon@arm.com, Catalin.Marinas@arm.com, hanjun.guo@linaro.org, graeme.gregory@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ddaney.cavm@gmail.com, Suravee.Suthikulpanit@amd.com

On 10/24/2015 12:20 PM, Hanjun Guo wrote:
> On 2015/10/15 22:05, Tomasz Nowicki wrote:
>> After refactoring DT code, we let ACPI to build ITS PCI MSI domain
>> and do requester ID to device ID translation using IORT table.
>>
>> We have now full PCI MSI domain stack, thus we can enable ITS initialization
>> from GICv3 core driver for ACPI scenario.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its-pci-msi.c | 48 ++++++++++++++++++++++++++++++--
>>   drivers/irqchip/irq-gic-v3.c             |  3 +-
>>   2 files changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> index cfd35da..09ae2d8 100644
>> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> @@ -15,6 +15,8 @@
>>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>>
>> +#include <linux/acpi.h>
>> +#include <linux/iort.h>
>>   #include <linux/msi.h>
>>   #include <linux/of.h>
>>   #include <linux/of_irq.h>
>> @@ -59,8 +61,10 @@ static int its_pci_msi_vec_count(struct pci_dev *pdev)
>>   static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
>>   {
>>   	struct its_pci_alias *dev_alias = data;
>> +	u32 dev_id;
>>
>> -	dev_alias->dev_id = alias;
>> +	dev_alias->dev_id = iort_find_pci_id(pdev, alias, &dev_id) == 0 ?
>> +								dev_id : alias;
>
> Hi tomasz, I think we need to re work this patch on top of tip/irq/core
> which has support for "msi-map" and "mai-parent" property support.
>

Indeed, I will rebase after some more comments related to other patches 
in this series.

Tomasz
