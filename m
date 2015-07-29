From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of strtoul()/simple_strtoul()
Date: Wed, 29 Jul 2015 22:04:57 +0200
Message-ID: <CAJZ5v0hHxXb-SKpFABFDf9UQcVMoLUmHzBctJ7SvYrfqbJJ6xw@mail.gmail.com>
References: <1438043542-2960-1-git-send-email-linux@roeck-us.net>
	<94F2FBAB4432B54E8AACC7DFDE6C92E37D329493@ORSMSX112.amr.corp.intel.com>
	<55B91DAF.3060605@roeck-us.net>
	<94F2FBAB4432B54E8AACC7DFDE6C92E37D3294E8@ORSMSX112.amr.corp.intel.com>
	<55B9304E.6020408@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34412 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbG2UE6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2015 16:04:58 -0400
In-Reply-To: <55B9304E.6020408@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi Guenter,

On Wed, Jul 29, 2015 at 9:58 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/29/2015 12:33 PM, Moore, Robert wrote:
>>>
>>> -----Original Message-----
>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>> Sent: Wednesday, July 29, 2015 11:39 AM
>>> To: Moore, Robert; rjw@rjwysocki.net
>>> Cc: lenb@kernel.org; Zheng, Lv; linux-acpi@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; devel@acpica.org
>>> Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of
>>> strtoul()/simple_strtoul()
>>>
>>> On 07/29/2015 10:51 AM, Moore, Robert wrote:
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>>>> Sent: Monday, July 27, 2015 5:32 PM
>>>>> To: rjw@rjwysocki.net
>>>>> Cc: lenb@kernel.org; Moore, Robert; Zheng, Lv;
>>>>> linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>> devel@acpica.org; Guenter Roeck
>>>>> Subject: [PATCH v2] acpi: Use kstrtoul() instead of
>>>>> strtoul()/simple_strtoul()
>>>>>
>>>>> simple_strtoul() is deprecated; replace with kstrtoul() and
>>>
>>> kstrtouint().
>>>>
>>>>
>>>> The ACPICA code is os-independent and cannot use these functions (at
>>>
>>> least not directly).
>>>>
>>>>
>>>>
>>> Odd argument, given that kstrtoul() is used already in the acpi code.
>>
>>
>> They are not in the os-independent ACPICA code. The ACPI-related drivers
>> are another story, since they are OS-dendent.
>>
>
> That this OS independent code mandates functions such as strtoul(),
> which may not exist in a target OS, and that it maps strtoul() to
> simple_strtoul() in a global include file, doesn't seem to be
> correct either and is asking for repeated trouble. I would have
> hoped that at the very least such mappings would be implemented
> in local include files.

The header is obviously OS-dependent and it does what it does just
because simple_strtoul() is available and serves the purpose.

As I said in the previous message, the strtoul() used by ACPICA might
be redefined in terms of kstroul().

And the change in sysfs.c is still OK.  Do you want me to apply this
change only?

Thanks,
Rafael
