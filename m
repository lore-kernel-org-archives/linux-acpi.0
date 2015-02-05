From: Al Stone <al.stone@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v8 02/21] acpi: fix acpi_os_ioremap for
 arm64
Date: Thu, 05 Feb 2015 09:42:19 -0700
Message-ID: <54D39D6B.5090304@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org> <2422968.Es7R0p3loO@vostro.rjw.lan> <1422984576.18187.82.camel@deneb.redhat.com> <20150204112508.GB26006@e104818-lin.cambridge.arm.com> <1423066107.18187.99.camel@deneb.redhat.com> <20150204175734.GI26006@e104818-lin.cambridge.arm.com> <1423076294.18187.103.camel@deneb.redhat.com> <20150205104149.GA18158@e104818-lin.cambridge.arm.com> <1423144447.18187.110.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:54232 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbbBEQmX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2015 11:42:23 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so28795194igd.4
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2015 08:42:22 -0800 (PST)
In-Reply-To: <1423144447.18187.110.camel@deneb.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Langsdorf <mlangsdo@redhat.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kerne

On 02/05/2015 06:54 AM, Mark Salter wrote:
> On Thu, 2015-02-05 at 10:41 +0000, Catalin Marinas wrote:
>> On Wed, Feb 04, 2015 at 06:58:14PM +0000, Mark Salter wrote:
>>> On Wed, 2015-02-04 at 17:57 +0000, Catalin Marinas wrote:
>>>> On Wed, Feb 04, 2015 at 04:08:27PM +0000, Mark Salter wrote:
>>>>> acpi_os_remap() is used to map ACPI tables. These tables may be in ram
>>>>> which are already included in the kernel's linear RAM mapping. So we
>>>>> need ioremap_cache to avoid two mappings to the same physical page
>>>>> having different caching attributes.
>>>>
>>>> What's the call path to acpi_os_ioremap() on such tables already in the
>>>> linear mapping? I can see an acpi_map() function which already takes
>>>> care of the RAM mapping case but there are other cases where
>>>> acpi_os_ioremap() is called directly. For example,
>>>> acpi_os_read_memory(), can it be called on both RAM and I/O?
>>>
>>> acpi_map() is the one I've seen.
>>
>> By default, if should_use_kmap() is not patched for arm64, it translates
>> to page_is_ram(); acpi_map() would simply use a kmap() which returns the
>> current kernel linear mapping on arm64.
> 
> The problem with kmap() is that it only maps a single page. I've seen
> tables over 4k which is why I patched acpi_map() not to use kmap() on
> arm64.

Right.  Mark replied to this before I could; using kmap() enforced a 4k
(one page) limit that we kept breaking with some ACPI tables being larger
than that (DSDTs and SSDTs, fwiw).  This would lead to some very odd behaviors
when most but not all of a device definition was within the page; using the
table checksums was one way of detecting the issues.

>>
>>> I'm not sure about others.
>>
>> Question for the ARM ACPI guys: what happens if you implement
>> acpi_os_ioremap() on arm64 as just ioremap()? Do you get any WARN_ON()
>> (__ioremap_caller() checks whether the memory is RAM)?
>>
> 
> 
> 
> _______________________________________________
> Linaro-acpi mailing list
> Linaro-acpi@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-acpi
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
