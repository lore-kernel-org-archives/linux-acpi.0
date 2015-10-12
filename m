From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 0/4] PCI: ACPI: Setting up DMA coherency for PCI device from _CCA attribute
Date: Mon, 12 Oct 2015 22:27:29 +0200
Message-ID: <3864683.NagPOmtRbX@vostro.rjw.lan>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com> <55F0EF79.3090202@amd.com> <561C0F45.8090107@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54397 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751790AbbJLT6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2015 15:58:50 -0400
In-Reply-To: <561C0F45.8090107@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday, October 12, 2015 02:51:33 PM Suravee Suthikulpanit wrote:
> Hi Rafael,
> 
> On 9/9/15 21:48, Suthikulpanit, Suravee wrote:
> > Hi Rafael,
> >
> > On 9/10/2015 3:38 AM, Rafael J. Wysocki wrote:
> >> On Wednesday, September 09, 2015 07:16:49 PM Suthikulpanit, Suravee
> >> wrote:
> >>> >Hi All,
> >>> >
> >>> >Are there any other concerns about this patch series?
> >> I have none, but then it sort of missed the merge window.
> >>
> >> I can easily queue it up for the next one unless it is super-urgent,
> >> but in that case I need to know why that's the case.
> >>
> >
> > This is not urgent. This mainly needed to enable the ACPI PCI supports
> > for ARM64 which is still work in progress.
> >
> > Thanks,
> > Suravee
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Just wondering if you are planning to queue this series up for 4.4 as well?

You don't seem to have addressed the Bjorn's comments on patch [2/4].

They need to be addressed before I can take this series.

Thanks,
Rafael

