From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: Question about FADT length
Date: Fri, 09 May 2014 16:44:36 +0800
Message-ID: <536C9574.3040005@linaro.org>
References: <5369EB5A.6070906@linaro.org> <1AE640813FDE7649BE1B193DEA596E880255ADFD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42655 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250AbaEIIpA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 May 2014 04:45:00 -0400
Received: by mail-pa0-f42.google.com with SMTP id rd3so4131175pab.1
        for <linux-acpi@vger.kernel.org>; Fri, 09 May 2014 01:45:00 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880255ADFD@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>

Hi Lv,

On 2014-5-9 9:45, Zheng, Lv wrote:
> Hi,
> 
> Using size instead of version field to determine FADT version has been talked for many times.
> I didn't see a real case that was persuasive enough to introduce this change.
> Do you have real platforms for us to examine?

There are some changes for the FADT in the new coming ACPI spec
which changed the field of "reserved4" into other useful information,
and the name of that field was changed also. So if we want to accommodate
that change, we should modify the "reserved4" in the macro of
ACPI_FADT_V2_SIZE too. If any change to the FADT in the future, we may
modify it again, so I think constant value for the macros would
be better.

Thanks
Hanjun

> 
> Thanks and best regards
> -Lv
> 
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Hanjun Guo
>> Sent: Wednesday, May 07, 2014 4:14 PM
>>
>> Hi,
>>
>> I ran into some compile errors when I was prototyping the code
>> for the proposals in ASWG, it turns out that some field in FADT is
>> changed and "reserved4[0]" used in ACPI_FADT_V2_SIZE will
>> cause the error.
>>
>> So my question is that the length of very version of FADT is
>> fixed, why not use a constant value for this puspose?
>>
>> Here is the code:
>>
>> /*
>>   * Sizes of the various flavors of FADT. We need to look closely
>>   * at the FADT length because the version number essentially tells
>>   * us nothing because of many BIOS bugs where the version does not
>>   * match the expected length. In other words, the length of the
>>   * FADT is the bottom line as to what the version really is.
>>   *
>>   * For reference, the values below are as follows:
>>   *     FADT V1  size: 0x074
>>   *     FADT V2  size: 0x084
>>   *     FADT V3  size: 0x0F4
>>   *     FADT V4  size: 0x0F4
>>   *     FADT V5  size: 0x10C
>>   */
>> #define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)
>> #define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (reserved4[0]) + 3)
>> #define ACPI_FADT_V3_SIZE       (u32) (ACPI_FADT_OFFSET (sleep_control))
>> #define ACPI_FADT_V5_SIZE       (u32) (sizeof (struct acpi_table_fadt))
>>
>> Why not  #define ACPI_FADT_V1_SIZE 0x074 ?
>> Did I miss something? any clarify will be appreciated :)
>>
>> Thanks
>> Hanjun
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

