From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFC v1 00/25] Optimize irq flow handler
Date: Wed, 20 May 2015 18:23:22 +0800
Message-ID: <555C609A.3000203@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <20150520101616.GA20163@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20150520101616.GA20163@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Matthias Brugger <matthias.bgg@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 2015/5/20 18:16, Ingo Molnar wrote:
> 
> * Jiang Liu <jiang.liu@linux.intel.com> wrote:
> 
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
> 
> Those kinds of identical titles are not acceptable.
Hi Ingo,
	Those patches with identical titles will be merged into one
when ready for merging, they are split for review only.
Thanks!
Gerry

> 
> Thanks,
> 
> 	Ingo
> 
