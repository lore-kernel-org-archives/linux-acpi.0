From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of strtoul()/simple_strtoul()
Date: Wed, 29 Jul 2015 13:37:12 -0700
Message-ID: <55B93978.9070306@roeck-us.net>
References: <1438043542-2960-1-git-send-email-linux@roeck-us.net>	<94F2FBAB4432B54E8AACC7DFDE6C92E37D329493@ORSMSX112.amr.corp.intel.com>	<55B91DAF.3060605@roeck-us.net>	<94F2FBAB4432B54E8AACC7DFDE6C92E37D3294E8@ORSMSX112.amr.corp.intel.com>	<55B9304E.6020408@roeck-us.net> <CAJZ5v0hHxXb-SKpFABFDf9UQcVMoLUmHzBctJ7SvYrfqbJJ6xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hHxXb-SKpFABFDf9UQcVMoLUmHzBctJ7SvYrfqbJJ6xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org

On 07/29/2015 01:04 PM, Rafael J. Wysocki wrote:
> Hi Guenter,
>
> On Wed, Jul 29, 2015 at 9:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 07/29/2015 12:33 PM, Moore, Robert wrote:
>>>>
>>>> -----Original Message-----
>>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>>> Sent: Wednesday, July 29, 2015 11:39 AM
>>>> To: Moore, Robert; rjw@rjwysocki.net
>>>> Cc: lenb@kernel.org; Zheng, Lv; linux-acpi@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; devel@acpica.org
>>>> Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of
>>>> strtoul()/simple_strtoul()
>>>>
>>>> On 07/29/2015 10:51 AM, Moore, Robert wrote:
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>>>>> Sent: Monday, July 27, 2015 5:32 PM
>>>>>> To: rjw@rjwysocki.net
>>>>>> Cc: lenb@kernel.org; Moore, Robert; Zheng, Lv;
>>>>>> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>>> devel@acpica.org; Guenter Roeck
>>>>>> Subject: [PATCH v2] acpi: Use kstrtoul() instead of
>>>>>> strtoul()/simple_strtoul()
>>>>>>
>>>>>> simple_strtoul() is deprecated; replace with kstrtoul() and
>>>>
>>>> kstrtouint().
>>>>>
>>>>>
>>>>> The ACPICA code is os-independent and cannot use these functions (at
>>>>
>>>> least not directly).
>>>>>
>>>>>
>>>>>
>>>> Odd argument, given that kstrtoul() is used already in the acpi code.
>>>
>>>
>>> They are not in the os-independent ACPICA code. The ACPI-related drivers
>>> are another story, since they are OS-dendent.
>>>
>>
>> That this OS independent code mandates functions such as strtoul(),
>> which may not exist in a target OS, and that it maps strtoul() to
>> simple_strtoul() in a global include file, doesn't seem to be
>> correct either and is asking for repeated trouble. I would have
>> hoped that at the very least such mappings would be implemented
>> in local include files.
>
> The header is obviously OS-dependent and it does what it does just
> because simple_strtoul() is available and serves the purpose.
>
> As I said in the previous message, the strtoul() used by ACPICA might
> be redefined in terms of kstroul().
>
> And the change in sysfs.c is still OK.  Do you want me to apply this
> change only?
>

Let's step back a bit. The problem I was trying to solve was that
there were two definitions of strtoul(), which caused compile errors
for some builds.

libcfs_string.h 105 #define strtoul(str, endp, base) simple_strtoul(str, endp, base)
aclinux.h       122 #define strtoul simple_strtoul

The first was in lustre code. My patch to remove that definition
has been accepted, so now there is only one such definition left.

Fixing the sysfs code only might make some sense - I'll leave that
up to you - but it doesn't address the problem I was trying to solve,
which is that strtoul() is defined in a global but driver specific include
file (include/linux/...). That definition would still be there and may
cause trouble again if someone else defines strtoul elsewhere for similar
reasons.

A fix might be to move the definition of strtoul from aclinux.h to
some include file in drivers/acpi, but I don't know the code well
enough to know if that is even feasible, or which file to move it to.

Thanks,
Guenter
