From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH 4/7] acpi, apei, ghes: Factor out NMI error notification
 context.
Date: Fri, 23 May 2014 14:06:47 +0200
Message-ID: <537F39D7.6090309@linaro.org>
References: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org> <1397056476-9183-5-git-send-email-tomasz.nowicki@linaro.org> <20140513194125.GD8760@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:64450 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaEWMGC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 May 2014 08:06:02 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so4630690wgg.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 May 2014 05:06:00 -0700 (PDT)
In-Reply-To: <20140513194125.GD8760@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@suse.de, m.chehab@samsung.com, linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On 13.05.2014 21:41, Borislav Petkov wrote:
> On Wed, Apr 09, 2014 at 05:14:32PM +0200, Tomasz Nowicki wrote:
>> Use CONFIG_ACPI_APEI_NMI to isolate NMI error notification path. NMI related
>> data and functions are grouped so they can be wrapped inside one
I have missed end of sentence. I should goes like that:

Use CONFIG_ACPI_APEI_NMI to isolate NMI error notification path. NMI 
related data and functions are grouped so they can be wrapped inside one
#ifdefs CONFIG_ACPI_APEI_NMI.

>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> ---
>>   drivers/acpi/apei/ghes.c |   54 +++++++++++++++++++++++++---------------------
>>   1 file changed, 30 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index ca8387e..7a0d66e 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -53,7 +53,9 @@
>>   #include <asm/mce.h>
>>   #endif
>>   #include <asm/tlbflush.h>
>> +#ifdef CONFIG_ACPI_APEI_NMI
>>   #include <asm/nmi.h>
>> +#endif
>
> This, again, can be avoided with adding arch-specific versions and empty
> default stubs.
>

I had that thoughts too. Looking at simple MCE calls, yes, it does make 
sense to create corresponding arch-specific version and provide logic as 
needed. I think that NMI is much more complicated. NMI context is 
tightly coupled with the rest of GHES mechanisms like pool memory, list 
locks etc. which are GHES locally available. I am not saying it is 
impossible, I am just concerned if it makes sense to create e.g. 
apei-nmi.c arch-specific file and export necessary GHES mechanisms just 
for NMI purpose. Please let me know your opinion on this.

Regards,
Tomasz
