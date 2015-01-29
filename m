From: Jon Masters <jcm@redhat.com>
Subject: Re: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param
 for "acpi" and pass acpi=force to enable ACPI
Date: Thu, 29 Jan 2015 13:44:36 -0500
Message-ID: <54CA7F94.6000305@redhat.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>	<1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>	<CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>	<CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>	<20150128181453.GG31752@e104818-lin.cambridge.arm.com>	<54C92804.5090806@codeaurora.org>	<20150129151956.GF8951@e104818-lin.cambridge.arm.com>	<CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>	<54CA7A42.5080800@codeaurora.org> <CAKv+Gu_a6_zjt=MsRuQH2rr05XxDayy0gACtbPXZaDAyhWrigg@mail.gmail.com> <54CA7D4A.5090709@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42819 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbbA2SqH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Jan 2015 13:46:07 -0500
In-Reply-To: <54CA7D4A.5090709@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh@kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Mark Brown <broonie@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ja

On 01/29/2015 01:34 PM, Timur Tabi wrote:
> On 01/29/2015 12:28 PM, Ard Biesheuvel wrote:
>> The UEFI stub in the kernel uses the DTB file format (FDT) to pass
>> information about the UEFI memory map and system table to the kernel.
>> It does so even if there is no device tree that describes the
>> platform. In this case, the file only contains a /chosen DT node, and
>> nothing else, and it is up to the kernel to figure out that it can ask
>> UEFI for a set of ACPI tables that it can use instead to configure the
>> system. Otherwise, the /chosen node properties are added to a device
>> tree that contains the full platform description.
>>
>> The problem is that we have to decide how to distinguish a
>> conventional device tree DTB from a DTB that only exists to
>> communicate the UEFI entry points.
> 
> Ah, that's exactly what I'm seeing.  The UEFI stub in our kernel 
> generates a DTB, and therefore I always need to put acpi=force on our 
> kernel command line.

I expect some of the distros to patch ACPI always enabled. So from my
point of view this affects only those wanting to follow upstream.

Jon.

