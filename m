From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
Date: Mon, 25 Mar 2019 15:04:50 +0000
Message-ID: <5b06cafb-f1c7-768a-22f5-bb69a877ea64@codethink.co.uk>
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
 <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
 <20190325115118.GP9224@smile.fi.intel.com>
 <20190325130413.GT9224@smile.fi.intel.com>
 <d67bb260-863c-1131-1323-711c3d2e227d@codethink.co.uk>
 <20190325150142.GE9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325150142.GE9224@smile.fi.intel.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 25/03/2019 15:01, Andy Shevchenko wrote:
> On Mon, Mar 25, 2019 at 02:42:09PM +0000, Thomas Preston wrote:
>> On 25/03/2019 13:04, Andy Shevchenko wrote:
>>> On Mon, Mar 25, 2019 at 01:51:18PM +0200, Andy Shevchenko wrote:
>>>> On Mon, Mar 25, 2019 at 10:31:13AM +0100, Rafael J. Wysocki wrote:
> 
>>>> Though one thing I would like to add (not directly related to the patch
>>>> per se), i.e. it would be nice to keep such examples under meta-acpi [1]
>>>> umbrella as a database for such excerpts.
>>>>
>>>> Thomas, can you do that?
>>>>
>>>> [1]: https://github.com/westeri/meta-acpi
>>
>> I will :)
> 
> Thank you! I will take either GH PR, or you may send an email to maintainers,
> i.e. Mika and me (PR is preferable because it would be seen publicly)
> 

I will get around to this, later this week.

>>>>>> +               Name (_HID, "TITMP75") /* _HID will appear in sysfs */
>>>
>>> Sorry for not noticing earlier.
>>>
>>> Is this an official ID for the chip? We discourage people to invent ACPI IDs on
>>> their own.
> 
>> The device is a TI tmp75b temperature sensor [0]. The HID is completely
>> made up, I'm afraid. It doesn't exist in the registry.
> 
> Thanks for clarification. In that case I would rather recommend to use simple
> PRP0001 as a _HID.
> 

Alright, I will resend with this modification.

>> [0] http://www.ti.com/lit/ds/symlink/tmp75b.pdf
> 
