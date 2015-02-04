From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Wed, 4 Feb 2015 10:41:11 -0600
Message-ID: <CAErSpo69LoS0P_bzJ2JJyF=H_YyJua85FCJ7DdMi2_na=aHRiA@mail.gmail.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan> <1422984576.18187.82.camel@deneb.redhat.com>
 <8901765.mLfPOCUyAN@vostro.rjw.lan> <20150204104832.GF8656@n2100.arm.linux.org.uk>
 <CAErSpo71fVU5mJgXnxMwiE_TUrNyfSYHo5RDF-=u2BK5grDYAw@mail.gmail.com> <20150204162536.GJ8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:47214 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965319AbbBDQlc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 11:41:32 -0500
Received: by mail-qc0-f177.google.com with SMTP id p6so2110640qcv.8
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2015 08:41:32 -0800 (PST)
In-Reply-To: <20150204162536.GJ8656@n2100.arm.linux.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Salter <msalter@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Mark Langsdorf <mlangsdo@redhat.com>, linaro-acpi@lists.linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yijing Wang <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, phoenix.liyi@huawei.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.o>

On Wed, Feb 4, 2015 at 10:25 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 04, 2015 at 09:53:28AM -0600, Bjorn Helgaas wrote:
>> On Wed, Feb 4, 2015 at 4:48 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Moreover, __weak is positively harmful when you consider it adds bloat
>> > and dead code - the overriden __weak function is left behind in the
>> > resulting final image.
>>
>> Huh, I didn't realize that.  Is that a linker bug, or is there some
>> reason the weak function has to be in the final image?  I tried a
>> trivial test on x86 with gcc-4.8.2/ld-2.24, and I think the weak
>> function text was omitted, but a string constant used only by the weak
>> function was included.
> ...
> The reason this happens is because normally, each function text is
> emitted into the .text section of the object file, one after each
> other.  When the image is linked, the linker copies the contents of
> the complete input section to the output file, and then resolves the
> symbolic information and relocations.

OK, that makes sense.  Thanks a lot for the detailed explanation!
