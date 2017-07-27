From: "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
Subject: RE: [PATCH] ACPIi / lpat: Fix typos and kernel-doc style
Date: Thu, 27 Jul 2017 06:10:03 +0000
Message-ID: <3C3E65E75D9910479323816378A812E7411082F5@BGSMSX104.gar.corp.intel.com>
References: <1500662682-29595-1-git-send-email-sumeet.r.pawnikar@intel.com>
 <2216383.aA2G1z59Fu@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdG0GLi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 02:11:38 -0400
In-Reply-To: <2216383.aA2G1z59Fu@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


>-----Original Message-----
>From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>Sent: Thursday, July 27, 2017 12:29 AM
>To: Pawnikar, Sumeet R <sumeet.r.pawnikar@intel.com>
>Cc: lenb@kernel.org; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH] ACPIi / lpat: Fix typos and kernel-doc style

Just now, I observed that the commit header has extra "i" after ACPI as mentioned in below line. My bad :(
Do you want me to resend this with correcting it ?

>
>On Saturday, July 22, 2017 12:14:42 AM Sumeet Pawnikar wrote:
>> This patch fix the typos in function header of acpi_lpat_raw_to_temp
>> and acpi_lpat_temp_to_raw.
>>
>> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
>> ---
>>  drivers/acpi/acpi_lpat.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_lpat.c b/drivers/acpi/acpi_lpat.c index
>> c1c4877..2cd9f73 100644
>> --- a/drivers/acpi/acpi_lpat.c
>> +++ b/drivers/acpi/acpi_lpat.c
>> @@ -25,7 +25,7 @@
>>   * @raw: the raw value, used as a key to get the temerature from the
>>   *       above mapping table
>>   *
>> - * A positive converted temperarure value will be returned on
>> success,
>> + * A positive converted temperature value will be returned on
>> + success,
>>   * a negative errno will be returned in error cases.
>>   */
>>  int acpi_lpat_raw_to_temp(struct acpi_lpat_conversion_table
>> *lpat_table, @@ -55,11 +55,11 @@ int acpi_lpat_raw_to_temp(struct
>acpi_lpat_conversion_table *lpat_table,
>>   * acpi_lpat_temp_to_raw(): Return raw value from temperature through
>>   * LPAT conversion table
>>   *
>> - * @lpat: the temperature_raw mapping table
>> + * @lpat_table: the temperature_raw mapping table
>>   * @temp: the temperature, used as a key to get the raw value from the
>>   *        above mapping table
>>   *
>> - * A positive converted temperature value will be returned on
>> success,
>> + * The raw value will be returned on success,
>>   * a negative errno will be returned in error cases.
>>   */
>>  int acpi_lpat_temp_to_raw(struct acpi_lpat_conversion_table
>> *lpat_table,
>>
>
>Applied, thanks!

