From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
Date: Fri, 30 Jan 2015 15:12:14 +0000
Message-ID: <CAKv+Gu-+iQtMqzrh+hahOSvcSyF2tP-=0VjRU6A42vNnXRYuTg@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
	<1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
	<CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
	<CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
	<20150128181453.GG31752@e104818-lin.cambridge.arm.com>
	<54C92804.5090806@codeaurora.org>
	<20150129151956.GF8951@e104818-lin.cambridge.arm.com>
	<CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com>
	<20150130111311.GA27542@e104818-lin.cambridge.arm.com>
	<54CB99B5.7070505@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59430 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762547AbbA3PMP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jan 2015 10:12:15 -0500
Received: by mail-ie0-f169.google.com with SMTP id rl12so4040137iec.0
        for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2015 07:12:15 -0800 (PST)
In-Reply-To: <54CB99B5.7070505@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh@kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Mark Brown <broonie@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>"linux-arm-kernel@lists.infradead.org" <linux-a>

On 30 January 2015 at 14:48, Timur Tabi <timur@codeaurora.org> wrote:
> Catalin Marinas wrote:
>>
>> Anyway, rather than a "I-created-an-empty-dtb" property, I would
>> actually say something like "dtb-contains-no-hardware-description".
>
>
> Why do we need a property for this?  Wouldn't the absence of a hardware
> description be the best way to see if the dtb contains no hardware
> description?  It's like putting a sign on an empty bookshelf that says,
> "there are no books here."
>

So what constitutes a 'hardware description'? A /cpu node? A memory node?
I don't think there is a mandated minimal set of nodes, even if
booting without cpu and memory nodes doesn't get you very far.

So those should go hand in hand: if we are going to implement logic
that decides a DTB is considered empty if it has no /cpu node, we
should update the boot protocol to mandate the presence of a /cpu node
for DT boot, and not change the rules every couple of months if
someone's use case requires it.

-- 
Ard.
