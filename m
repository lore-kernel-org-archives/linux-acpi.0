From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPICA: Remove redundant macro defines for ACPI_DEBUG_PRINT()
 and ACPI_DEBUG_PRINT_RAW()
Date: Wed, 29 May 2013 18:00:32 +0800
Message-ID: <51A5D1C0.3070008@linaro.org>
References: <51A08098.1090807@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE78E65@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:41329 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965379Ab3E2KBK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 May 2013 06:01:10 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf10so8057195pab.38
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2013 03:01:10 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE78E65@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Jiang Liu <liuj97@gmail.com>

On 2013-5-29 1:07, Moore, Robert wrote:
> This was fixed some time ago in the main ACPICA source, and should have made it into Linux by now.

Ok, I noticed the ACPICA patch set sent out today by Lv Zheng,
and it is fixed in this patch set.

Thanks
Hanjun Guo

> 
> 
>> -----Original Message-----
>> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
>> Sent: Saturday, May 25, 2013 2:13 AM
>> To: Zheng, Lv
>> Cc: Wysocki, Rafael J; Moore, Robert; linux-acpi@vger.kernel.org;
>> patches@linaro.org; linaro-kernel@lists.linaro.org; Jiang Liu
>> Subject: [PATCH] ACPICA: Remove redundant macro defines for
>> ACPI_DEBUG_PRINT() and ACPI_DEBUG_PRINT_RAW()
>>
>> In commit 0377b5acba2 (ACPICA: Merge all debug output macros into a single
>> file, acoutput.), the patch introduces redundant macro defines for
>> ACPI_DEBUG_PRINT() and ACPI_DEBUG_PRINT_RAW(), just remove it.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  include/acpi/acoutput.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index
>> 4f52ea7..e1c7474 100644
>> --- a/include/acpi/acoutput.h
>> +++ b/include/acpi/acoutput.h
>> @@ -447,8 +447,6 @@
>>  #define ACPI_DUMP_TABLES(a, b)
>>  #define ACPI_DUMP_PATHNAME(a, b, c, d)
>>  #define ACPI_DUMP_BUFFER(a, b)
>> -#define ACPI_DEBUG_PRINT(pl)
>> -#define ACPI_DEBUG_PRINT_RAW(pl)
>>  #define ACPI_IS_DEBUG_ENABLED(level, component) 0
>>
>>  /* Return macros must have a return statement at the minimum */
>> -- 1.8.2.1

