From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH V1 00/11] MMCONFIG refactoring and ARM64 PCI hostbridge
 init based on ACPI
Date: Tue, 8 Dec 2015 11:43:33 -0600
Message-ID: <566716C5.50902@arm.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:53055 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521AbbLHRnp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2015 12:43:45 -0500
In-Reply-To: <1445963922-22711-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com
Cc: linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, Narinder.Dhillon@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, wangyijing@huawei.com, tglx@linutronix.de, jiang.liu@linux.intel.com, linux-arm-kernel@lists.infradead.org

On 10/27/2015 11:38 AM, Tomasz Nowicki wrote:
>  From the functionality point of view this series might be split into two logic parts:
> 1. Making MMCONFIG code arch-agnostic which allows all architectures to collect
>     PCI config regions and used when necessary.
> 2. Using generic MMCONFIG code and introducing ACPI based PCI hostbridge
>     initialization for ARM64


Tested with legacy interrupts on ARM Juno R1, HP m400 (APM Potenza), and 
APM mustang. The latter two platforms have an additional pci quirk patch 
applied (to be posted shortly) to fix their problems with the config 
space accessors.

Tested-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks!



