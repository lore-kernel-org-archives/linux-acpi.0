From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 0/3] Preparation for arranging hotplug memory in ZONE_MOVABLE.
Date: Tue, 20 Aug 2013 09:07:58 +0800
Message-ID: <5212C16E.2040105@cn.fujitsu.com>
References: <1376473028-29380-1-git-send-email-tangchen@cn.fujitsu.com> <15319045.yHqauUVrf3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15319045.yHqauUVrf3@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, liwanp@linux.vnet.ibm.com, tj@kernel.org, zhangyanfei@cn.fujitsu.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/20/2013 07:40 AM, Rafael J. Wysocki wrote:
> On Wednesday, August 14, 2013 05:37:05 PM Tang Chen wrote:
>> These three trivial patches are from patch-set "Arrange hotpluggable memory as ZONE_MOVABLE."
>> And they have been acked and reviewed by many people.
>>
>> Hope they can be merged first. And the rest patches are coming soon.
>>
>>
>> Tang Chen (3):
>>    acpi: Print Hot-Pluggable Field in SRAT.
>>    earlycpio.c: Fix the confusing comment of find_cpio_data().
>>    acpi: Kill macro INVALID_TABLE().
>>
>>   arch/x86/mm/srat.c |   11 +++++++----
>>   drivers/acpi/osl.c |   36 ++++++++++++++++++++----------------
>>   lib/earlycpio.c    |   27 ++++++++++++++-------------
>>   3 files changed, 41 insertions(+), 33 deletions(-)
>
> I've queued up this series for 3.12.

Hi Rafael,

Thanks a lot. :)
