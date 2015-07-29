From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of strtoul()/simple_strtoul()
Date: Wed, 29 Jul 2015 21:57:34 +0200
Message-ID: <CAJZ5v0gEfxd7EhONYGq8xEt8pOCVRE-F=YeJULfLB-=VZuE55A@mail.gmail.com>
References: <1438043542-2960-1-git-send-email-linux@roeck-us.net>
	<94F2FBAB4432B54E8AACC7DFDE6C92E37D329493@ORSMSX112.amr.corp.intel.com>
	<55B91DAF.3060605@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33682 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbG2T5f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2015 15:57:35 -0400
In-Reply-To: <55B91DAF.3060605@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Moore, Robert" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi Guenter,

On Wed, Jul 29, 2015 at 8:38 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/29/2015 10:51 AM, Moore, Robert wrote:
>>
>>
>>
>>> -----Original Message-----
>>> From: Guenter Roeck [mailto:linux@roeck-us.net]
>>> Sent: Monday, July 27, 2015 5:32 PM
>>> To: rjw@rjwysocki.net
>>> Cc: lenb@kernel.org; Moore, Robert; Zheng, Lv;
>>> linux-acpi@vger.kernel.org;
>>> linux-kernel@vger.kernel.org; devel@acpica.org; Guenter Roeck
>>> Subject: [PATCH v2] acpi: Use kstrtoul() instead of
>>> strtoul()/simple_strtoul()
>>>
>>> simple_strtoul() is deprecated; replace with kstrtoul() and kstrtouint().
>>
>>
>> The ACPICA code is os-independent and cannot use these functions (at least
>> not directly).
>>
>>
> Odd argument, given that kstrtoul() is used already in the acpi code.

Boib is right, the change in sysfs.c is OK, but the one in evgpeinit.c
isn't (this code is automatically generated from the upstream ACPICA
source and manual updates of it are painful).

You might provide a strtoul() wrapper around kstrtoul() instead of its
definition in acpi/platform/aclinux.h, though.

Thanks,
Rafael
