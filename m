From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of strtoul()/simple_strtoul()
Date: Sun, 02 Aug 2015 01:19:19 -0700
Message-ID: <55BDD287.70004@roeck-us.net>
References: <1438043542-2960-1-git-send-email-linux@roeck-us.net> <20150802071643.GF32270@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37504 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbbHBITZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2015 04:19:25 -0400
In-Reply-To: <20150802071643.GF32270@amd>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org

On 08/02/2015 12:16 AM, Pavel Machek wrote:
> On Mon 2015-07-27 17:32:22, Guenter Roeck wrote:
>> simple_strtoul() is deprecated; replace with kstrtoul() and kstrtouint().
>> Return an error if the value passed to the sysfs attribute is not
>> a number.
>>
>> Drop the definition of strtoul() since it is no longer needed.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: An additional use of strtoul() was introduced with commit 4fa4616e.
>>      Replace it as well.
>>
>>   drivers/acpi/acpica/evgpeinit.c | 5 +++--
>>   drivers/acpi/sysfs.c            | 8 ++++++--
>>   include/acpi/platform/aclinux.h | 1 -
>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
>> index ea4c0d3fca2d..aa1e8c1f2d4a 100644
>> --- a/drivers/acpi/acpica/evgpeinit.c
>> +++ b/drivers/acpi/acpica/evgpeinit.c
>> @@ -326,6 +326,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
>>   	u32 gpe_number;
>>   	char name[ACPI_NAME_SIZE + 1];
>>   	u8 type;
>> +	int err;
>>
>>   	ACPI_FUNCTION_TRACE(ev_match_gpe_method);
>>
>> @@ -377,8 +378,8 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
>>
>>   	/* 4) The last two characters of the name are the hex GPE Number */
>>
>> -	gpe_number = strtoul(&name[2], NULL, 16);
>> -	if (gpe_number == ACPI_UINT32_MAX) {
>> +	er = kstrtouint(&name[2], 16, &gpe_number);
>> +	if (err < 0 || gpe_number == ACPI_UINT32_MAX) {
>
> Are you sure you compile-tested this?
>

I was, but maybe not ;-). Since the patch was rejected it does not really matter.

Guenter

