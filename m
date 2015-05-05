From: Marian Marinov <mm-l@yuhu.biz>
Subject: Re: Patch breaks suspend
Date: Tue, 05 May 2015 11:38:50 +0300
Message-ID: <5548819A.5050503@yuhu.biz>
References: <55453334.9030002@yuhu.biz> <2970725.6ieOiJg9HH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from blackpearl.yuhu.biz ([85.14.7.126]:43518 "EHLO
	BlackPearl.yuhu.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbbEEIi6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2015 04:38:58 -0400
In-Reply-To: <2970725.6ieOiJg9HH@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>

On 05/05/2015 02:37 AM, Rafael J. Wysocki wrote:
> On Saturday, May 02, 2015 11:27:32 PM Marian Marinov wrote:
>> Hi guys,
>> I have Lenovo T520 with one SSD and one SATA drive.
>>
>> I tried to upgrade to Linux 4.0 and found that after suspend and resume I can't access the second (SATA) drive.
>> Both drives have bios encryption enabled.
>>
>> I did a bisect and found that the following patch causes the issue:
>> commit 5d5132059a1f652de9dc2d62a8ff15561e648d11
>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Date:   Sat Feb 22 00:48:31 2014 +0100
>>
>>     ACPI / ATA: Add hotplug contexts to ACPI companions of SATA devices
>>    
>>     Modify the SATA subsystem to add hotplug contexts to ACPI companions
>>     of SATA devices and ports instead of registering special ACPI dock
>>     operations using register_hotplug_dock_device().
>>    
>>     That change will allow the entire code handling those special ACPI
>>     dock operations to be dropped in the next commit.
>>    
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>     Reviewed-by: Aaron Lu <aaron.lu@intel.com>
>>     Acked-by: Tejun Heo <tj@kernel.org>
>>
>> Unfortunately I do not understand this part of the code and have no idea what I can do.
>> Any pointers would be very appreciated.
> Well, not right from the top of my head, but this looks really suspicious to me.
>
> Can you please file a bug entry for this at bugzilla.kernel.org (in the ACPI/BIOS
> category), assign it to me and CC Aaron?
BUG created: https://bugzilla.kernel.org/show_bug.cgi?id=97731

Added you and Aaron to the CC list.

What additional info can I provide you? Would you like any debug info from the kernel it self?
Dmesg output?

Marian
