From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: Possible deadlock related to CPU hotplug and kernfs
Date: Mon, 7 Sep 2015 11:11:19 +0800
Message-ID: <55ED0057.1000806@linux.intel.com>
References: <55E54FE2.7030601@linux.intel.com>
 <20150902161445.GI22326@mtj.duckdns.org> <12669324.bPBpI0mOPP@vostro.rjw.lan>
 <20150903161904.GC10394@mtj.duckdns.org>
 <CAJZ5v0izmv8CycKd0hjEkSBUmPeRmWWMUMgfMHkXK-0uDJFPaQ@mail.gmail.com>
 <55E94642.6020707@linux.intel.com>
 <CAJZ5v0itBxg_gQzEe=nVfxOVpw5WBs9u8VDP7PHoyXyirnmdPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33954 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbbIGDLW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Sep 2015 23:11:22 -0400
In-Reply-To: <CAJZ5v0itBxg_gQzEe=nVfxOVpw5WBs9u8VDP7PHoyXyirnmdPQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux hotplug mailing <linux-hotplug@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On 2015/9/4 22:16, Rafael J. Wysocki wrote:
> Hi,
> 
> On Fri, Sep 4, 2015 at 9:20 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>> On 2015/9/4 4:08, Rafael J. Wysocki wrote:
>>> Hi Tejun,
>>>
>>> On Thu, Sep 3, 2015 at 6:19 PM, Tejun Heo <tj@kernel.org> wrote:
>>>> Hello, Rafael.
>>>>
>>>> On Thu, Sep 03, 2015 at 02:58:16AM +0200, Rafael J. Wysocki wrote:
>>>>> So acpi_device_hotplug() calls lock_device_hotplug() which simply
>>>>> acquires device_hotplug_lock.  It is held throughout the entire
>>>>> hot-add/hot-remove code path.
>>>>>
>>>>> Witing anything to /sys/devices/system/cpu/cpux/online goes through
>>>>> online_store() in drivers/base/core.c and that does
>>>>> lock_device_hotplug_sysfs() which then attempts to acquire
>>>>> device_hotplug_lock using mutex_trylock().  And it only calls
>>>>> either device_online() or device_offline() if it ends up with the
>>>>> lock held.
>>>>>
>>>>> Quite frankly, I don't see how these particular two code paths can
>>>>> deadlock in any way.
>>>>>
>>>>> So either a third code path is involved which is not executed
>>>>> under device_hotplug_lock, or lockdep needs to be told to actually
>>>>> take device_hotplug_lock into account in this case IMO.
>>>>
>>>> Hmm... all sysfs rw functions are protected from removal.  ie. by
>>>> default, removal of a sysfs file drains in-flight rw operations, so
>>>> the hot plug path grabs a lock and then tries to remove a file and
>>>> writing to the online file makes the file's write method to try to
>>>> grab the same lock.  It deadlocks if the hotunplug path already has
>>>> the lock and trying to drain the online file for removal.
>>>
>>> My point is that you cannot get into that situation.  If hotplug
>>> already holds device_hotplug_lock, the write to "online" will end up
>>> doing restart_syscall().
>>>
>>> If the "online" code path is holding the lock, hotplug cannot acquire
>>> it and cannot proceed.
>>>
>>> Am I missing anything?
>> Hi Rafael,
>>         I think your are right. The lock_device_hotplug_sysfs() has
>> already provided a solution for such a deadlock scenario. And there's
>> another related code path at boot as:
>> smp_init()
>>         ->cpu_up()
>>                 ->cpu_hotplug_begin()
>>         So it seems to be a false alarm. Any way to teach lockdep
>> about this to get rid of the false alarm?
> 
> Well, maybe we could call lock_device_hotplug() from that code path too?
Hi Rafael,
	Adding lock_device_hotplug() to smp_init() doesn't solve the
issue. So it seems to be an false alarm of lockdep, and I don't know
how to get rid of such an lockdep false alarm:(
Thanks!
Gerry
