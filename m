From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFC v1 01/11] genirq: Introduce struct irq_common_data to host
 shared irq data
Date: Mon, 18 May 2015 10:58:19 +0800
Message-ID: <5559554B.6090008@linux.intel.com>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com> <1430709339-29083-2-git-send-email-jiang.liu@linux.intel.com> <554C1E3F.7050306@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8373 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbbERC6Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 May 2015 22:58:25 -0400
In-Reply-To: <554C1E3F.7050306@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yun Wu (Abel)" <wuyun.wu@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Jason Cooper <jason@lakedaemon.net>, Grant Likely <grant.likely@linaro.org>, Kevin Cernekee <cernekee@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On 2015/5/8 10:23, Yun Wu (Abel) wrote:
> On 2015/5/4 11:15, Jiang Liu wrote:
> 
> [...]
>> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
>> index dd1109fb241e..3010e99abf3e 100644
>> --- a/include/linux/irqdesc.h
>> +++ b/include/linux/irqdesc.h
>> @@ -47,6 +47,7 @@ struct pt_regs;
>>   * @name:		flow handler name for /proc/interrupts output
>>   */
>>  struct irq_desc {
>> +	struct irq_common_data	irq_common_data;
> 
> Hi Gerry,
> 
> Please update description as well. :)
Thanks, Abel!

