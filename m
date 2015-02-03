From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Tue, 03 Feb 2015 17:08:42 +0800
Message-ID: <54D0901A.2080406@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org> <2422968.Es7R0p3loO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2422968.Es7R0p3loO@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyij
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B402=E6=9C=8803=E6=97=A5 06:14, Rafael J. Wysocki wrote:
> On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
>> From: Mark Salter <msalter@redhat.com>
>>
>> The acpi_os_ioremap() function may be used to map normal RAM or IO
>> regions. The current implementation simply uses ioremap_cache(). Thi=
s
>> will work for some architectures, but arm64 ioremap_cache() cannot b=
e
>> used to map IO regions which don't support caching. So for arm64, us=
e
>> ioremap() for non-RAM regions.
>>
>> CC: Rafael J Wysocki <rjw@rjwysocki.net>
>> Signed-off-by: Mark Salter <msalter@redhat.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   include/acpi/acpi_io.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
>> index 444671e..9d573db 100644
>> --- a/include/acpi/acpi_io.h
>> +++ b/include/acpi/acpi_io.h
>> @@ -1,11 +1,17 @@
>>   #ifndef _ACPI_IO_H_
>>   #define _ACPI_IO_H_
>>
>> +#include <linux/mm.h>
>>   #include <linux/io.h>
>>
>>   static inline void __iomem *acpi_os_ioremap(acpi_physical_address =
phys,
>>   					    acpi_size size)
>>   {
>> +#ifdef CONFIG_ARM64
>> +	if (!page_is_ram(phys >> PAGE_SHIFT))
>> +		return ioremap(phys, size);
>> +#endif
>
> I don't want to see #ifdef CONFIG_ARM64 in this file.
>
> There are multiple examples of how things like this are done.  Genera=
lly,
> the logic is "If the architecture provides its own function for this,=
 use
> that one, or use the generic one provided here otherwise."

OK. I think weak function would work.

Thanks
Hanjun
