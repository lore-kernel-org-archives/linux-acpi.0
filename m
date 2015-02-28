From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: regression in 4.0.0-rc1 with r8169 ethernet
Date: Sat, 28 Feb 2015 16:45:11 +0800
Message-ID: <54F18017.7060203@linux.intel.com>
References: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com> <CAPM=9txFHJXbhXQsSyL=h2oG83tr5ZnJj7G6cFtVQ+EDWdXv6w@mail.gmail.com> <alpine.LSU.2.11.1502271534570.10799@er-systems.de> <1588858.OaSxSRONoY@vostro.rjw.lan> <54F17715.6050506@linux.intel.com> <32040DE9-54EE-4A7D-883A-F578ACFE4338@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3112 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbbB1IpS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Feb 2015 03:45:18 -0500
In-Reply-To: <32040DE9-54EE-4A7D-883A-F578ACFE4338@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Voegtle <tv@lio96.de>, Dave Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Lv Zheng <lv.zheng@intel.com>

On 2015/2/28 16:36, Marcel Holtmann wrote:
> Hi Jiang,
> 
>>>> I have the same problem with a Asrock Q1900B-ITX mainboard with 
>>>> a Intel Celeron J1900 onboard.
>>>>
>>>> I did a bisect and ended up with:
>>>>
>>>> 593669c2ac0fe18baee04a3cd5539a148aa48574 is the first bad commit
>>>>
>>>> commit 593669c2ac0fe18baee04a3cd5539a148aa48574
>>>> Author: Jiang Liu <jiang.liu@linux.intel.com>
>>>> Date:   Thu Feb 5 13:44:46 2015 +0800
>>>>
>>>>     x86/PCI/ACPI: Use common ACPI resource interfaces to simplify 
>>>> implementation
>>>>
>>>>
>>>> I can revert this quite big commit on current git head (4f671fe) with no 
>>>> problems and then everything is fine again.
>>>
>>> Thanks for nailing this one!
>>>
>>> It really wasn't supposed to make any functional difference, though, so there
>>> must be some subtle mistake that escaped everyone in it.
>>>
>>> I'll have a look at that and hopefully Jiang Liu will be able to help in the
>>> meantime too.
>> Hi all,
>> 	Sorry for slow response, just return from Chinese New Holidays:)
>> Hi Thomas,
>> 	Could you please help to provide the dmesgs before and after the
>> revert?
> 
> just grab a Minnowboard Max and test this by yourself. It has the same problem. The MAC address is ff:ff:ff:ff:ff:ff with this patch. Once I reverted it, the MAC address is correctly read again.
Hi Marcel,
	I have no access to any Minnowboard Max board, so couldn't test
it by myself. Could you please help to forward the two dmesg files you
have sent to Bjorn in the original email?
Thanks!
Gerry

> 
> Regards
> 
> Marcel
> 
