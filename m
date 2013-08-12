From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Mon, 12 Aug 2013 14:28:06 -0700
Message-ID: <52095366.4020106@zytor.com>
References: <1375956979-31877-1-git-send-email-tangchen@cn.fujitsu.com> <20130812145016.GI15892@htj.dyndns.org> <5208FBBC.2080304@zytor.com> <20130812152343.GK15892@htj.dyndns.org> <52090D7F.6060600@gmail.com> <20130812164650.GN15892@htj.dyndns.org> <52092811.3020105@gmail.com> <20130812202029.GB8288@mtj.dyndns.org> <3908561D78D1C84285E8C5FCA982C28F31CB74A1@ORSMSX106.amr.corp.intel.com> <20130812205456.GC8288@mtj.dyndns.org> <3908561D78D1C84285E8C5FCA982C28F31CB7552@ORSMSX106.amr.corp.intel.com> <CAE9FiQVB18Rzf0nHi_1=TK8oHZ=tttOZRfrmVK=UqzHEc=8mww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAE9FiQVB18Rzf0nHi_1=TK8oHZ=tttOZRfrmVK=UqzHEc=8mww@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, Tejun Heo <tj@kernel.org>, Tang Chen <imtangchen@gmail.com>, Tang Chen <tangchen@cn.fujitsu.com>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "lenb@kernel.org" <lenb@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "trenn@suse.de" <trenn@suse.de>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>, "wency@cn.fujitsu.com" <wency@cn.fujitsu.com>, "laijs@cn.fujitsu.com" <laijs@cn.fujitsu.com>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>, "izumi.taku@jp.fujitsu.com" <izumi.taku@jp.fujitsu.com>, "mgorman@suse.de" <mgorman@suse.de>, "minchan@kernel.org" <minchan@ke>
List-Id: linux-acpi@vger.kernel.org

On 08/12/2013 02:25 PM, Yinghai Lu wrote:
> On Mon, Aug 12, 2013 at 2:11 PM, Luck, Tony <tony.luck@intel.com> wrote:
>>>> The only fly I see in the ointment here is the crazy fragmentation of physical
>>
>> Just an idle, slightly related, question.  Will a 64-bit X86 kernel work if the physical  load address is >4GB?
> 
> Yes. for smp booting, will need some pages under 1M for trampoline AP.
> 

Not just for SMP anymore, either.

	-hpa


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
