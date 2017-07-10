From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] ACPI / X86: Add KIOX000A accelerometer on GPD win to
 always_present_ids array
Date: Mon, 10 Jul 2017 12:25:47 +0200
Message-ID: <03da3e2a-0a81-e4b8-092e-211d2f08cf93@redhat.com>
References: <20170709190514.3437-1-hdegoede@redhat.com>
 <20170709190514.3437-3-hdegoede@redhat.com>
 <1499682140.22624.318.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbdGJKZu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 06:25:50 -0400
In-Reply-To: <1499682140.22624.318.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi,

On 10-07-17 12:22, Andy Shevchenko wrote:
> On Sun, 2017-07-09 at 21:05 +0200, Hans de Goede wrote:
>> The GPD win BIOS dated 20170320 has disabled the accelerometer, the
>> drivers sometimes cause crashes under Windows and this is how the
>> manufacturer has solved this :|
>>
>> I see no other way to keep the accelerometer working under Windows
>> then
>> adding it to the always_present_ids array.
>>
> 
>> +	ENTRY("KIOX000A", "1", ICPU(INTEL_FAM6_ATOM_AIRMONT), {
>> +		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>> +		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>> +		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
> 
> 4 entries for 2 entry array?

No, there are 2 dmi_system_id array entries, one with the
actual id, one empty to terminate the array. The
dmi_system_id array entry has a matches array which is 4 big:

struct dmi_system_id {
         int (*callback)(const struct dmi_system_id *);
         const char *ident;
         struct dmi_strmatch matches[4];
         void *driver_data;
};

And the ENTRY macro puts the passed in arguments into the matches
array.

Regards,

Hans
