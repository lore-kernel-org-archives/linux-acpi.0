From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm, test: add mock SMART data payload
Date: Thu, 7 Apr 2016 09:41:38 -0700
Message-ID: <CAPcyv4h_UewYGrxe7N9spKc5Zn7M=HD4=n7re4EMZxzYqgbV-Q@mail.gmail.com>
References: <20160407005349.30117.44157.stgit@dwillia2-desk3.jf.intel.com>
	<32455510.OFm6LAzW1p@c203>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35226 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756831AbcDGQlk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2016 12:41:40 -0400
Received: by mail-oi0-f50.google.com with SMTP id p188so105658579oih.2
        for <linux-acpi@vger.kernel.org>; Thu, 07 Apr 2016 09:41:39 -0700 (PDT)
In-Reply-To: <32455510.OFm6LAzW1p@c203>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Apr 7, 2016 at 1:27 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> On Mittwoch, 6. April 2016 17:53:49 CEST Dan Williams wrote:
>> Provide simulated SMART data to enable the ndctl implementation of SMART
>> data retrieval and parsing.
>>
>> The payload is defined here, "Section 4.1 SMART and Health Info
>> (Function Index 1)":
>>
>>     http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>
> [...]
>
>> @@ -20,6 +20,35 @@ struct nd_cmd_smart {
>>       __u8 data[128];
>>  } __packed;
>>
>> +enum {
>> +     ND_SMART_HEALTH_VALID   = 1 << 0,
>> +     ND_SMART_TEMP_VALID     = 1 << 1,
>> +     ND_SMART_SPARES_VALID   = 1 << 2,
>> +     ND_SMART_ALARM_VALID    = 1 << 3,
>> +     ND_SMART_USED_VALID     = 1 << 4,
>> +     ND_SMART_SHUTDOWN_VALID = 1 << 5,
>> +     ND_SMART_VENDOR_VALID   = 1 << 6,
>> +     ND_SMART_TEMP_TRIP      = 1 << 0,
>> +     ND_SMART_SPARE_TRIP     = 1 << 1,
>> +     ND_SMART_NON_CRITICAL_HEALTH    = 1 << 0,
>> +     ND_SMART_CRITICAL_HEALTH        = 1 << 1,
>> +     ND_SMART_FATAL_HEALTH           = 1 << 2,
>> +};
>
> Why not use BIT() instead of that 1 << x stuff and #define instead of the
> abstract enum?

Can't use BIT() since that definition isn't exported in a user header.
I don't have a strong opinion of #define vs anonymous enum, I'll go
ahead and switch it over.
