From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 4/4] acpi,memory-hotplug : store the node id in acpi_memory_device
Date: Fri, 12 Oct 2012 14:59:56 -0400
Message-ID: <CAHGf_=rf+ginaNjYifJJVa6sy2Hd41tdJQtC_JtmGaneyKqbkA@mail.gmail.com>
References: <506C0AE8.40702@jp.fujitsu.com> <506C0F53.5030500@jp.fujitsu.com>
 <CAHGf_=o6K71u4+OVsLvfCSRmOTk12TpsgKwsJO6bGdd_6dYnyA@mail.gmail.com> <507276FD.4020808@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45285 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab2JLTAR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Oct 2012 15:00:17 -0400
In-Reply-To: <507276FD.4020808@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org

On Mon, Oct 8, 2012 at 2:47 AM, Wen Congyang <wency@cn.fujitsu.com> wrote:
> At 10/06/2012 02:56 AM, KOSAKI Motohiro Wrote:
>> On Wed, Oct 3, 2012 at 6:11 AM, Yasuaki Ishimatsu
>> <isimatu.yasuaki@jp.fujitsu.com> wrote:
>>> From: Wen Congyang <wency@cn.fujitsu.com>
>>>
>>> The memory device has only one node id. Store the node id when
>>> enable the memory device, and we can reuse it when removing the
>>> memory device.
>>
>> You don't explain why we need this. Then nobody can review nor ack.
>>
>
> This patch doesn't fix any problem. Its purpose is: avoid to calculate
> the node id twice.

ditto.

Please separate patches as logical change. You should make problem fix
patch set.
