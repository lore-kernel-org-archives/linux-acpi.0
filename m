From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch v5 0/6] Consolidate ACPI PCI root common code into ACPI
 core
Date: Thu, 30 Jul 2015 15:58:49 +0800
Message-ID: <55B9D938.4020204@linux.intel.com>
References: <1433780448-18636-1-git-send-email-jiang.liu@linux.intel.com>
 <55B8C46F.4090109@linaro.org> <20150729203027.GB9640@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9991 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbbG3H6y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jul 2015 03:58:54 -0400
In-Reply-To: <20150729203027.GB9640@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Yijing Wang <wangyijing@huawei.com>, Lv Zheng <lv.zheng@intel.com>, "lenb @ kernel . org" <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org

On 2015/7/30 4:30, Bjorn Helgaas wrote:
> On Wed, Jul 29, 2015 at 08:17:51PM +0800, Hanjun Guo wrote:
>> Hi Bjorn, Rafael,
>>
>> Just kindly ping for this patchset, it has been reviewed and tested,
>> can it be merged in 4.3?
> 
> There are open review issues, e.g., IORESOURCE_MEM_8AND16BIT, so I'm not
> ready to merge it as-is.  I'll look at it some more, but we definitely need
> some revisions.
Hi Bjorn,
	Thanks for review and I will handle all review comments in
coming days.
Regards!
Gerry
