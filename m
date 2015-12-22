From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Tue, 22 Dec 2015 11:36:38 -0500
Message-ID: <56797C16.2020802@redhat.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <1450278993-12664-23-git-send-email-tn@semihalf.com> <EE11001F9E5DDD47B7634E2F8A612F2E1EC14C0F@lhreml503-mbb> <201512211510.32029.arnd@arndb.de> <335CDE2E-B588-43A8-8665-6023AFD0EA04@redhat.com> <EE11001F9E5DDD47B7634E2F8A612F2E1EC17CAC@lhreml503-mbb>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33673 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbbLVQhF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Dec 2015 11:37:05 -0500
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1EC17CAC@lhreml503-mbb>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Nowicki <tn@semihalf.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "okaya@codeaurora.org" <okaya@codeaurora.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "Stefano.Stabellini@eu.citrix.com" <Stefano.Stabellini@eu.citrix.com>, "robert.richter@caviumnetworks.com" <robert.richter@caviumnetworks.com>, "mw@semihalf.com" <mw@semihalf.com>, "Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>, "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Wangyijing <wangyijing@huawei.com>, "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>

On 12/22/2015 04:29 AM, Gabriele Paoloni wrote:
> Hi Jon, thanks for replying
> 
>> -----Original Message-----
>> From: Jon Masters [mailto:jcm@redhat.com]
>> Sent: 21 December 2015 23:11
>> To: Arnd Bergmann
>> Cc: Gabriele Paoloni; Tomasz Nowicki; bhelgaas@google.com;
>> will.deacon@arm.com; catalin.marinas@arm.com; rjw@rjwysocki.net;
>> hanjun.guo@linaro.org; Lorenzo.Pieralisi@arm.com; okaya@codeaurora.org;
>> jiang.liu@linux.intel.com; Stefano.Stabellini@eu.citrix.com;
>> robert.richter@caviumnetworks.com; mw@semihalf.com; Liviu.Dudau@arm.com;
>> ddaney@caviumnetworks.com; tglx@linutronix.de; Wangyijing;
>> Suravee.Suthikulpanit@amd.com; msalter@redhat.com; linux-
>> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linaro-
>> acpi@lists.linaro.org; jchandra@broadcom.com
>> Subject: Re: [PATCH V2 22/23] pci, acpi: Match PCI config space
>> accessors against platfrom specific quirks.
>>
>> Sorry for top-posting. A quick note that SMBIOS3 is required by SBBR so
>> it can be presumed that compliant platforms will provide quirks via DMI.
> 
> Ok so you completely clarified my question 1). Many Thanks for this

No problem. One of the (many) reasons I pushed for requiring SMBIOS/DMI
in SBBR (I was lead author of one of the early drafts of that document)
was to make the experience ultimately equivalent across architectures.
We already know how to do quirks and handle platform deviations, and the
major Operating System vendors did not want to reinvent the wheel.

Jon.

