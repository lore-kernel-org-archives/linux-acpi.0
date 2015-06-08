From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFT v2 11/48] ipu: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
Date: Mon, 08 Jun 2015 19:37:09 +0800
Message-ID: <55757E65.5030401@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com> <1433391238-19471-12-git-send-email-jiang.liu@linux.intel.com> <20150608111658.GL28601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:31514 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbbFHLhQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2015 07:37:16 -0400
In-Reply-To: <20150608111658.GL28601@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org

On 2015/6/8 19:16, Vinod Koul wrote:
> On Thu, Jun 04, 2015 at 12:13:21PM +0800, Jiang Liu wrote:
>> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
>> already have a pointer to corresponding irq_desc.
>>
>> Do the same thing to avoid pattern "irq_get_chip_data(data->irq)".
> 
> And I am missing the context, it is a bad practice to send some part of the
> series without giving context. Is this dependent on something else...?
This patch set touches too many files, so I didn't send the cover letter
to all maintainers. The whole patch set is to simplify core irq
interfaces by killing the 'irq' parameter. Please refer to
lkml.org/lkml/2015/6/4/113

And it may depends on preceding patches in tip/x86/apic branch, so it
would be safer to handle the patch set altogether.
Thanks!
Gerry
