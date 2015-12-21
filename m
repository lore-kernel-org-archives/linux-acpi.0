From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI hostbridge init based on ACPI
Date: Mon, 21 Dec 2015 23:39:05 +0100
Message-ID: <201512212339.05923.arnd@arndb.de>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <201512211515.55447.arnd@arndb.de> <b3750d7918712f6035ea875d90c25471.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:54279 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbLUWkY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2015 17:40:24 -0500
In-Reply-To: <b3750d7918712f6035ea875d90c25471.squirrel@www.codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Okaya@codeaurora.org
Cc: Tomasz Nowicki <tn@semihalf.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, bhelgaas@google.com, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, jiang.liu@linux.intel.com, stefano.stabellini@eu.citrix.com, robert.richter@caviumnetworks.com, mw@semihalf.com, liviu.dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, suravee.suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com

On Monday 21 December 2015, Okaya@codeaurora.org wrote:
> Thanks, I won't be touching the acpi tables then and I will assume the
> hack had a problem. It was trying to remap the io range of the second root
> port  to the first port io address map.

If all domains share the same I/O space, you should only map it once
of course.

> I was getting a warning from resource.c
> 
> Btw, when I tested the io ranges before, kernel didn't accept anything
> below 1k like 0. That is why my range starts at 1k.

This is PCIBIOS_MIN_IO, it defines what I/O port numbers can be dynamically
assigned to PCI devices, but you should still map the entire 64K area per
domain, including the first 4K that can be used for legacy ISA compatibility.

	Arnd
