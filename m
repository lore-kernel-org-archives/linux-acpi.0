From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH part1 v6 4/6] x86/mem-hotplug: Support initialize page
 tables in bottom-up
Date: Thu, 10 Oct 2013 10:12:59 -0700
Message-ID: <5256E01B.9050802@zytor.com>
References: <20131009192040.GA5592@mtj.dyndns.org>	 <1381352311.5429.115.camel@misato.fc.hp.com>	 <20131009211136.GH5592@mtj.dyndns.org>	 <1381363135.5429.138.camel@misato.fc.hp.com>	 <20131010010029.GA10900@mtj.dyndns.org>	 <1381415809.24268.40.camel@misato.fc.hp.com>	 <20131010153518.GB13276@htj.dyndns.org>	 <1381422249.24268.68.camel@misato.fc.hp.com>	 <20131010164623.GD13276@htj.dyndns.org>	 <1381423840.24268.70.camel@misato.fc.hp.com>	 <20131010165522.GE13276@htj.dyndns.org> <1381424390.26234.1.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1381424390.26234.1.camel@misato.fc.hp.com>
Sender: owner-linux-mm@kvack.org
To: Toshi Kani <toshi.kani@hp.com>, Tejun Heo <tj@kernel.org>
Cc: Zhang Yanfei <zhangyanfei.yes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J . Wysocki" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, "vasilis.liaskovitis@profitbricks.com" <vasilis.liask>
List-Id: linux-acpi@vger.kernel.org

On 10/10/2013 09:59 AM, Toshi Kani wrote:
> On Thu, 2013-10-10 at 12:55 -0400, Tejun Heo wrote:
>> On Thu, Oct 10, 2013 at 10:50:40AM -0600, Toshi Kani wrote:
>>> Can you elaborate why we need to parse the device hierarchy before
>>> setting up page tables?
>>
>> How else can one put the page tables on the "local device"?  Am I
>> missing something?
> 
> The local page table item is gone under the current plan as you
> suggested...
> 

That would be a significant performance regression.

	-hpa


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
