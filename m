From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 1/5] x86, memhp, numa: Online memory-less nodes at boot
 time.
Date: Wed, 13 Jan 2016 12:56:02 +0800
Message-ID: <5695D8E2.6040908@cn.fujitsu.com>
References: <1452140425-16577-1-git-send-email-tangchen@cn.fujitsu.com> <1452140425-16577-2-git-send-email-tangchen@cn.fujitsu.com> <20160108182808.GZ1898@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160108182808.GZ1898@mtj.duckdns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: cl@linux.com, jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, tangchen@cn.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

Hi tj,

On 01/09/2016 02:28 AM, Tejun Heo wrote:
> Hello,
>
> On Thu, Jan 07, 2016 at 12:20:21PM +0800, Tang Chen wrote:
>> +static void __init init_memory_less_node(int nid)
>>   {
>> +	unsigned long zones_size[MAX_NR_ZONES] = {0};
>> +	unsigned long zholes_size[MAX_NR_ZONES] = {0};
> It doesn't cause any functional difference but it's a bit weird to use
> {0} because it explicitly says to initialize the first element to 0
> when the whole array needs to be cleared.  Wouldnt { } make more sense?

Yes. Will fix them.

>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index e23a9e7..9c4d4d5 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -736,6 +736,7 @@ static inline bool is_dev_zone(const struct zone *zone)
>>   
>>   extern struct mutex zonelists_mutex;
>>   void build_all_zonelists(pg_data_t *pgdat, struct zone *zone);
>> +void build_zonelists(pg_data_t *pgdat);
> This isn't used in this patch.  Contamination?

Sorry, I tried to build zone lists here. But it totally unnecessary and 
led to some problems.

I forgot to remove them when I fixed the problems. Will remove them.

Thx.

>
> Thanks.
>



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
