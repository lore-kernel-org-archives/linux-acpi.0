From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
Date: Thu, 2 Jun 2016 10:52:14 +0200
Message-ID: <574FF3BE.4010903@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33368 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbcFBIwT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jun 2016 04:52:19 -0400
Received: by mail-lf0-f43.google.com with SMTP id s64so29372738lfe.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jun 2016 01:52:18 -0700 (PDT)
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F767865@lhreml507-mbx>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rafael@kernel.org" <rafael@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>, "jchandra@broadcom.com" <jchandra@broadcom.com>
Cc: "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, "mw@semihalf.com" <mw@semihalf.com>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, Wangyijing <wangyijing@huawei.com>, "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>, "msalter@redhat.com" <msalter@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, "andrea.gallo@linaro.org" <andrea.gallo@linaro.org>, "dhdang@apm.com" <dhdang@apm.com>, "jeremy.linton@arm.com" <jeremy.linton@arm.com>, "liudongdong (C)" <liudongd>

Hi Gabriele,

On 01.06.2016 09:36, Gabriele Paoloni wrote:
> I think maybe it is worth to post this quirk mechanism as RFC on
> top of this v8 patchset, so that we can start to review it and
> make some progress on the quirks.

I've just posted my RFC patches, please see:
https://patchwork.ozlabs.org/patch/629121/

We can start review from there so that this series is not blocked.

Thanks,
Tomasz
