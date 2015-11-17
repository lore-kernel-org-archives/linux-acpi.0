From: Huang Shijie <shijie.huang@arm.com>
Subject: Re: [PATCH V1 10/10] acpi, gicv3, its: Use MADT ITS subtable to do
 PCI/MSI domain initialization.
Date: Tue, 17 Nov 2015 09:30:55 +0000
Message-ID: <20151117093053.GA2669@sha-win-147.asiapac.arm.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
 <1444917919-21152-11-git-send-email-tn@semihalf.com>
 <562B5B6E.2000305@huawei.com>
 <562B8E79.6010701@linaro.org>
 <20151117071115.GA2131@sha-win-147.asiapac.arm.com>
 <564AED6B.9050006@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:59602 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238AbbKQJbZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2015 04:31:25 -0500
In-Reply-To: <564AED6B.9050006@huawei.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, ddaney.cavm@gmail.com, linux-arm-kernel@lists.infradead.org

On Tue, Nov 17, 2015 at 05:03:39PM +0800, Hanjun Guo wrote:
Hi Hanjun,
> Hi Shijie,
> 
> On 2015/11/17 15:11, Huang Shijie wrote:
> > On Sat, Oct 24, 2015 at 03:58:17PM +0200, Tomasz Nowicki wrote:
> > Hi Tomasz,
> >> Indeed, I will rebase after some more comments related to other patches in
> >> this series.
> >>
> > Do you have any update about this patch set?
> > I want to test this patch set, but I met the fail when I git-am this
> > patch set to linux-next tree.
> 
> you can pull from git://git.linaro.org/leg/acpi/acpi.git, branch topic-pci
okay, I will do that.

thanks
Huang Shijie

