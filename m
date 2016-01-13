From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Wed, 13 Jan 2016 16:27:43 +0100
Message-ID: <56966CEF.1010701@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <56966C1C.1050902@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33804 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbcAMP3o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2016 10:29:44 -0500
Received: by mail-lb0-f176.google.com with SMTP id cl12so75200239lbc.1
        for <linux-acpi@vger.kernel.org>; Wed, 13 Jan 2016 07:29:44 -0800 (PST)
In-Reply-To: <56966C1C.1050902@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com

On 13.01.2016 16:24, Sinan Kaya wrote:
> on an ARM64 server with some nits.
>
> I started seeing these on an ACPI system. I didn't have these before when I tested Tomasz's
> branch yesterday. It must have been introduced after a rebase or a recent change.
>
> _#_dmesg_|_grep_of_irq
> [    3.130774] pci 0002:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    4.182526] pci 0002:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    5.187764] pci 0002:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    5.868518] pci 0003:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    5.910629] pci 0003:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    6.732817] pci 0006:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    7.777698] pci 0006:00:00.0: of_irq_parse_pci() failed with rc=-22
> [    8.782882] pci 0006:00:00.0: of_irq_parse_pci() failed with rc=-22
> / #

You got this because I had dropped patch from the previous series:
https://patchwork.ozlabs.org/patch/557504/
and this is expected.

Tomasz
