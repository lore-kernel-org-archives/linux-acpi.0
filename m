From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
Date: Thu, 17 Jan 2019 11:39:33 -0500
Message-ID: <3ef1915c-f3c0-84ea-d35e-c26a16e8f818@kernel.org>
References: <20190117161722.3945-1-okaya@kernel.org>
 <20190117163722.GE5023@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117163722.GE5023@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 1/17/2019 11:37 AM, Borislav Petkov wrote:
> On Thu, Jan 17, 2019 at 04:17:22PM +0000, Sinan Kaya wrote:
>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
>> specified directly.
>>
>> PCI_LOCKLESS_CONFIG depends on PCI but this dependency has not been
>> mentioned in the Kconfig.
>>
>> Add an explicit dependency here.
>>
>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   arch/x86/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 568f339595ed..0519da6f8ee4 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -199,7 +199,7 @@ config X86
>>   	select IRQ_FORCED_THREADING
>>   	select NEED_SG_DMA_LENGTH
>>   	select PCI_DOMAINS			if PCI
>> -	select PCI_LOCKLESS_CONFIG
>> +	select PCI_LOCKLESS_CONFIG		if PCI
>>   	select PERF_EVENTS
>>   	select RTC_LIB
>>   	select RTC_MC146818_LIB
>> -- 
> 
> Are there any more arch/x86/ fixes for the 5d32a66541c4 fallout floating
> around?
> 
> If so, pls merge them all together into a single patch so that we're
> done with this once and for all.
> 
> Also, I see a lot of build failures when doing randconfig builds for the
> stuff in drivers/platform/x86/Kconfig. Is someone picking those up too?
> 
> If not, I'd take 'em too in a single patch, if Darren and Andy are fine
> with it.

I'm only looking at PCI and ACPI related changes to be honest. The rest is
out of my expertise area.

I started a run of 1000 randconfig runs in the meantime. I'll collect the
results soon and follow up if there is something I can help.

> 
> Thx.
> 
