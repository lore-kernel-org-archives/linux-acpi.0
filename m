From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH V7 00/11] Support for generic ACPI based PCI host
 controller
Date: Fri, 20 May 2016 04:24:18 -0400
Message-ID: <9a9d2e00-efb4-2607-a410-43af1d3c97c3@redhat.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ED8DF51@lhreml503-mbs>
 <57331290.7070104@semihalf.com>
 <3d4aae09-51c4-f007-5100-191a4a85e27a@redhat.com>
 <CAKv+Gu8fdeJ9OvRSmtu9zyvcjK3O-4WU=jG=6-7t4xZwvV8d2g@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF540@lhreml503-mbs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38785 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932749AbcETIYa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 May 2016 04:24:30 -0400
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EDAF540@lhreml503-mbs>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rafael@kernel.org" <rafael@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>, "jchandra@broadcom.com" <jchandra@broadcom.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "dhdang@apm.com" <dhdang@apm.com>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, "jeremy.linton@arm.com" <jeremy.linton@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 05/20/2016 04:11 AM, Gabriele Paoloni wrote:
> Hi Ard, Jon

Hi Gabriele :)

> In our case (HiSilicon Hip05/Hip06) we are using the Designware IP
> that unfortunately is non-ECAM for the RC config space.

Yea, I know, and I've pinged them already.

> A possible ACPI table solution was discussed already in this thread
> 
> https://lkml.org/lkml/2016/3/14/722
> 
> where <<Name (_CID, "PNP0C02")  // Motherboard reserved resource>>
> is used to specify an Host Controller specific resource.
> It looks to me that this can be an approach that can accommodate
> different vendors/scenarios and Bjorn seemed to be quite ok with
> it.

Yeah, pondering that. We'll chat with a few others about it.

> It comes without saying that for future HW releases we all should
> make an effort to deliver fully ECAM compliant controllers.

Right. Like I said, a number of designs have been fixed already.

> What's your view about this approach?

Will followup over the weekend.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
