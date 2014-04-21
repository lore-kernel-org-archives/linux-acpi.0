From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: 3.14-rc: /proc/acpi/battery gone?
Date: Mon, 21 Apr 2014 19:29:10 +0800
Message-ID: <53550106.8080907@intel.com>
References: <20140314211456.GA23213@amd.pavel.ucw.cz> <201403150217.50526.s.L-H@gmx.de> <532471EC.1070107@intel.com> <201403160357.53858.s.L-H@gmx.de> <CAKb7UvjeW_vKQn_WjCawD7HDe7BKMYdH_HauFxFvUySkj1yvew@mail.gmail.com> <20140420130930.GD12135@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40049 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbaDUL2K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Apr 2014 07:28:10 -0400
In-Reply-To: <20140420130930.GD12135@amd.pavel.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Stefan Lippers-Hollmann <s.L-H@gmx.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>

On 04/20/2014 09:09 PM, Pavel Machek wrote:
> Hi!
>
>>>>        I just glance wmbattery code. I find the code in the acpi.c is already
>>>> using the new sysfs battery interfaces, right?
>>>
>>> By default, wmbattery appears to default to using upower as abstraction
>>> level, instead of querying sysfs itself directly.
>>>
>>> http://git.kitenet.net/?p=wmbattery.git;a=blob;f=autoconf/makeinfo.in;hb=HEAD
>>>
>>> which sets USE_UPOWER=1 by default.
>>>
>>> If USE_UPOWER=0 is set explicitly for the build, it reverts back to
>>> direct sysfs parsing - and yes, it does appear to adhere to the current
>>> sysfs API properly.
>>>
>>> The last remains, and the ability to parse procfs (which hasn't been
>>> default for quite some time already, in favour of using hal as
>>> abstraction layer) has finally been removed in
>>>
>>> http://git.kitenet.net/?p=wmbattery.git;a=commitdiff;h=833eb63a5ce4f2fb712a201b1db4f2db1700fddb
>>>
>>> The switch from procfs parsing to hal (by default at least) in turn
>>> happened with
>>>
>>> http://git.kitenet.net/?p=wmbattery.git;a=commitdiff;h=63c3d1a0b11e8ade1a5612bb5baa3d92e153bbbe
>>>
>>> in 2008 (before Debian squeeze/ oldstable). I have not investigated if
>>> hal then read from procfs or sysfs, but wmbattery at least didn't read
>>> from procfs itself, unless explicitly told to do so (USE_HAL=0) during
>>> the build since mid 2008.
>>>
>>> The current version of wmbattery however will never try to access
>>> /proc/acpi, the current version no longer knows of its existence.
>>>
>>> [Again, I'm not familiar with wmbattery myself and have never run it]
>>
>> Stefan,
>>
>> Thanks for looking into this. The newest wmbattery version indeed
>> supports upower. However, I haven't figured out how to get it to work.
>> That's obviously not the kernel's fault, but an unfortunate reality.
>> It seems to really want dbus to be running, but when I start dbus
>> (which nothing else on my system needs, apparently), it just hangs. My
>> knowledge of these things is, (un)fortunately non-existent, so I just
>> gave up on the upower approach. Running something as heavy as dbus
>> just for a silly dock app seems... silly as well.
>
> Any news on this one?
>
> It seems that delaying fsck on battery power also relies on
> /proc/acpi/battery...

Ok. I will prepare a patch to recover /proc/acpi/battery.

>
> https://bbs.archlinux.org/viewtopic.php?id=12168
>
> 									Pavel
>

