From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH 4/4] acpi,memory-hotplug : store the node id in acpi_memory_device
Date: Mon, 08 Oct 2012 14:47:25 +0800
Message-ID: <507276FD.4020808@cn.fujitsu.com>
References: <506C0AE8.40702@jp.fujitsu.com> <506C0F53.5030500@jp.fujitsu.com> <CAHGf_=o6K71u4+OVsLvfCSRmOTk12TpsgKwsJO6bGdd_6dYnyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAHGf_=o6K71u4+OVsLvfCSRmOTk12TpsgKwsJO6bGdd_6dYnyA@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org
List-Id: linux-acpi@vger.kernel.org

At 10/06/2012 02:56 AM, KOSAKI Motohiro Wrote:
> On Wed, Oct 3, 2012 at 6:11 AM, Yasuaki Ishimatsu
> <isimatu.yasuaki@jp.fujitsu.com> wrote:
>> From: Wen Congyang <wency@cn.fujitsu.com>
>>
>> The memory device has only one node id. Store the node id when
>> enable the memory device, and we can reuse it when removing the
>> memory device.
> 
> You don't explain why we need this. Then nobody can review nor ack.
> 

This patch doesn't fix any problem. Its purpose is: avoid to calculate
the node id twice.

Thanks
Wen Congyang

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
