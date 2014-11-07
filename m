From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Linaro-acpi] [RFC PATCH 3/4] arm64, acpi, pci: Add arch specific functions for mmconfig driver.
Date: Fri, 07 Nov 2014 15:12:45 +0100
Message-ID: <16660879.6KxQndPqBW@wuerfel>
References: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org> <1415366876-30811-4-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62964 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaKGOOn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2014 09:14:43 -0500
In-Reply-To: <1415366876-30811-4-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com, Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 07 November 2014 14:27:55 Tomasz Nowicki wrote:
> These calls allow to map/unmap PCI config space ranges (which are specified in
> MMCFG ACPI table).
> 
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 

Nothing in this patch looks arm64 specific, and most of it looks like a
copy of the x86 code.

	Arnd
