From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 0/5] ACPI / EC: Add reference counting for requests
 and cleans up the grace periods support.
Date: Thu, 12 Feb 2015 02:17:42 +0100
Message-ID: <54DBFF36.3060603@intel.com>
References: <20141119121615.GA2514@node.dhcp.inet.fi> <cover.1423183647.git.lv.zheng@intel.com> <1711204.9KEDEeQMDo@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E88026D4B94@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88026D4B94@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2/9/2015 3:23 AM, Zheng, Lv wrote:
> Hi, Rafael
>
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Friday, February 06, 2015 9:27 AM
>>
>> On Friday, February 06, 2015 08:57:37 AM Lv Zheng wrote:
>>> This patchset contains 3 cleanups related to the EC driver:
>>> 1. Command flushing (command grace period)
>>>     This patchset flushes EC commands before suspending/resuming, so that
>>>     there won't be timeout for the incomplete commands after resuming.
>>> 2. Query flushing (query grace period)
>>>     This patchset flushes EC event queries before suspending/resuming, so
>>>     that there won't be broken events remained in the firmware queue.
>>> 3. Command storming prevention
>>>     This patchset corrects command storming prevention logic because of
>>>     the GPE raw handler mode.
>>> The request reference count debugging messages can be used to detect broken
>>> EC transactions. It should always drop to 1 when the driver is idle during
>>> the runtime.
>>>
>>> Note that after flushing before suspending, EC GPE is still enabled to keep
>>> the old behavior.
>>>
>>> Lv Zheng (5):
>>>    ACPI/EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag.
>>>    ACPI/EC: Add command flushing support.
>>>    ACPI/EC: Refine command storm prevention support.
>>>    ACPI/EC: Add query flushing support.
>>>    ACPI/EC: Add GPE reference counting debugging messages.
>>>
>>>   drivers/acpi/ec.c       |  295 ++++++++++++++++++++++++++++++++++++++++-------
>>>   drivers/acpi/internal.h |    1 +
>>>   2 files changed, 254 insertions(+), 42 deletions(-)
>> So this is on top of the EC patches you sent previously, right?
> Yes.
>
> The sequence is:
> ACPICA 20150204 release: http://www.spinics.net/lists/linux-acpi/msg55623.html
> ACPI EC GPE race fixes: http://www.spinics.net/lists/linux-acpi/msg55633.html
> And this series.

Unfortunately, patch [4/5] from this series broke system suspend on Acer 
Aspire S5 for me.

Apparently, the box hangs hard during the last stage of suspend (after 
offlining nonboot CPUs).

The issue is 100% reproducible and reverting the patch (along with [5/5] 
that depends on it) fixes the problem, so I'm going to push the reverts 
to Linus on Friday.

I can send you an acpidump output from the affected machine, but I won't 
be able to do any testing on it before Feb 23, so reverting is the only 
viable option for the time being.

Please let me know if you want the acpidump output.

Kind regards,
Rafael
