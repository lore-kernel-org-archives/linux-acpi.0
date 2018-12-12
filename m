From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 16:31:01 -0500
Message-ID: <1cf7a2ce-0e1b-c329-a891-0cc9ae030f1b@kernel.org>
References: <20181212171941.7437-1-okaya@kernel.org>
 <20181212171941.7437-6-okaya@kernel.org>
 <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
 <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
 <CAJZ5v0iN+OkN0+wy=jGA33Uz+wQT7=zxF-TX3e-TrHDnr4=YRA@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C556C0D@ORSMSX122.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C556C0D@ORSMSX122.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Schmauss, Erik" <erik.schmauss@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/12/2018 4:16 PM, Schmauss, Erik wrote:
> 
> 
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rafael@kernel.org]
>> Sent: Wednesday, December 12, 2018 1:07 PM
>> To: okaya@kernel.org; Schmauss, Erik <erik.schmauss@intel.com>
>> Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Moore, Robert
>> <robert.moore@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
>> Len Brown <lenb@kernel.org>; devel@acpica.org; Linux Kernel Mailing List
>> <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
>> CONFIG_PCI is unset
>>
>> On Wed, Dec 12, 2018 at 8:34 PM Sinan Kaya <okaya@kernel.org> wrote:
>>>
>>> On 12/12/2018 2:02 PM, Schmauss, Erik wrote:
>>>>> ++ b/drivers/acpi/acpica/achware.h
>>>>> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
>>>>> acpi_gpe_xrupt_info *gpe_xrupt_info,
>>>> CONFIG_PCI is a Linux-ism. We should stay with the OS-independent
>>>> nature of ACPICA. Please use ACPI_PCI_CONFIGURED and put it above
>> the comment like so:
>>>>
>>>> #ifdef ACPI_PCI_CONFIGURED
>>>
>>> Thanks for the feedback. My search for ACPI_PCI_CONFIGURED returned
>> nothing.
>>>
>>> git grep ACPI_PCI_CONFIGURED
>>>
>>> @Rafael,
>>>
>>> How do you want to handle this?
>>
>> I think what Eric suggested is effectively to introduce a new ACPICA symbol.
>> Erik?
> 
> Yes, that's correct and you can add something like
> 
> #ifdef CONFIG_PCI
> #define ACPI_PCI_CONFIGURED
> #endif
> 
> in include/linux/platform/aclinux.h to enable it.
> 

OK. Let me rework this and test.
