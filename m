From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
Date: Thu, 29 Jan 2015 18:20:06 +0000
Message-ID: <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
	<1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
	<CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
	<CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
	<20150128181453.GG31752@e104818-lin.cambridge.arm.com>
	<54C92804.5090806@codeaurora.org>
	<20150129151956.GF8951@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:56186 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbbA2SUH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jan 2015 13:20:07 -0500
Received: by mail-ie0-f178.google.com with SMTP id rp18so36854144iec.9
        for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2015 10:20:06 -0800 (PST)
In-Reply-To: <20150129151956.GF8951@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Timur Tabi <timur@codeaurora.org>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh@kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Mark Brown <broonie@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kerne>

On 29 January 2015 at 15:19, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Jan 28, 2015 at 06:18:44PM +0000, Timur Tabi wrote:
>> On 01/28/2015 12:14 PM, Catalin Marinas wrote:
>> >> >So it looks like there's a whole conversation about this already in
>> >> >this thread that I didn't notice.  However, reading through all of it,
>> >> >I still don't understand sure why the presence of ACPI tables is
>> >> >insufficient to enable ACPI.
>>
>> > Because ACPI on arm64 is still experimental, no matter how many people
>> > claim that it is production ready in their private setups.
>>
>> Fair enough.  Does this mean that passing "acpi=force" on the kernel
>> command line is a requirement for ARM64 servers?
>
> Please read my other email and ideally the whole sub-thread. The
> acpi=force should only be required if the SoC is described (from
> firmware) by both DT and ACPI.
>
>> >> >In what situation would we want to ignore ACPI tables that are
>> >> >present?
>>
>> > When DT tables are also present (and for the first platforms, that's
>> > highly recommended, though not easily enforceable at the kernel level).
>>
>> My understanding is that the EFI stub creates a device tree (and it
>> contains some important information), so I don't understand how we can
>> ever have an ACPI-only platform on ARM64 servers.
>
> If EFI stub creates the DT itself (not passed by firmware), it will
> write some information in the chosen node that the rest of the kernel
> can make use of and take the appropriate decision on whether to use ACPI
> or not. That's something that will be used by kexec and Xen as well
> which may want to boot with ACPI tables outside an EFI environment.
>

If we are going with this solution, we should also mandate that an
ACPI enabled firmware should not supply a non-DT DTB, or we wouldn't
spot the difference. Not sure how likely this is, but I could imagine
a firmware setting up an initrd and hence populating the /chosen node
in an otherwise empty DTB. In this case, the stub would not add its
'I-created-an-empty-dtb' property.

-- 
Ard.
