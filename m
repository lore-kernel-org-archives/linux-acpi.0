From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
Date: Mon, 6 Oct 2014 17:31:47 +0100
Message-ID: <20141006163147.GA22482@srcf.ucam.org>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20140917012614.GA31214@srcf.ucam.org>
 <542C6FE9.10903@amd.com>
 <4872185.h11DQxW6kP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52123 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbaJFQcE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Oct 2014 12:32:04 -0400
Content-Disposition: inline
In-Reply-To: <4872185.h11DQxW6kP@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, mark.rutland@arm.com, graeme.gregory@linaro.org, marc.zyngier@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, astone@redhat.com, grant.likely@linaro.org, hanjun.guo@linaro.org, Sudeep.Holla@arm.com, olof@lixom.net, jason@lakedaemon.net, "Duran, Leo" <leo.duran@amd.com>, Jon Masters <jcm@redhat.com>

On Thu, Oct 02, 2014 at 10:39:18AM +0200, Arnd Bergmann wrote:

> I think part of the problem is that there is no specification for what
> an AHCI device should look like when it's not connected to a PCI
> bus, the AHCI document published by Intel just states:

One thing that has come out of further discussion on this - ACPI defines 
a _CLS object, which allows ACPI devices to declare compatibility with a 
PCI class device. We don't have support for it at the moment, but it 
would be easy enough to add this to the kernel and then just expose the 
AHCI PCI class via _CLS. That would avoid us having problems with people 
doing similar things with USB hosts.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
