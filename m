From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Tue, 22 Dec 2015 09:45:28 +0100
Message-ID: <56790DA8.6050606@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-23-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb>
 <201512211510.32029.arnd@arndb.de>
 <335CDE2E-B588-43A8-8665-6023AFD0EA04@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:32895 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbLVIrW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2015 03:47:22 -0500
Received: by mail-lb0-f176.google.com with SMTP id sv6so20638907lbb.0
        for <linux-acpi@vger.kernel.org>; Tue, 22 Dec 2015 00:47:21 -0800 (PST)
In-Reply-To: <335CDE2E-B588-43A8-8665-6023AFD0EA04@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>, "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, "mw@semihalf.com" <mw@semihalf.com>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Wangyijing <wangyijing@huawei.com>, "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>, msalter

On 22.12.2015 00:10, Jon Masters wrote:
> Sorry for top-posting. A quick note that SMBIOS3 is required by SBBR so it can be presumed that compliant platforms will provide quirks via DMI.
>

Thanks Jon for confirmation.

Tomasz
