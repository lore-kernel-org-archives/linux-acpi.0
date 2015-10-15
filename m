From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Patch v7 0/7] Consolidate ACPI PCI root common code into ACPI core
Date: Thu, 15 Oct 2015 23:49:06 +0200
Message-ID: <18082551.ZgPkP00eQT@vostro.rjw.lan>
References: <1444804182-6596-1-git-send-email-jiang.liu@linux.intel.com> <20151015204829.GH10442@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48817 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751244AbbJOVUX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2015 17:20:23 -0400
In-Reply-To: <20151015204829.GH10442@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On Thursday, October 15, 2015 03:48:29 PM Bjorn Helgaas wrote:
> On Wed, Oct 14, 2015 at 02:29:35PM +0800, Jiang Liu wrote:
> > From: Liu Jiang <jiang.liu@linux.intel.com>
> > 
> > This patch set consolidates common code to support ACPI PCI root on x86
> > and IA64 platforms into ACPI core, to reproduce duplicated code and
> > simplify maintenance. And a patch set based on previous version to support
> > ACPI based PCIe host bridge on ARM64 has been posted at:
> > https://lkml.org/lkml/2015/5/26/207
> > 
> > It's based on latest mainstream kernel. It passes Fengguang's 0day test
> > suite and has been tested on two IA64 platforms and one x86 platform.
> > 
> > V6->V7:
> > 1) Improve commit message according to Bjorn's suggestion.
> > 2) Move arch specific logic(code) from ACPI core into arch code
> >    according to Bjorn's review comments.
> 
> Thanks for cleaning this up; I think it looks much better.
> 
> As far as I'm concerned, this series is ready to go.  I assume Rafael
> will merge it.

Yes, I'm going to do that.

Thanks a lot for your help with the review!

Rafael

