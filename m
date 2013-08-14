From: KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Wed, 14 Aug 2013 15:40:31 -0400
Message-ID: <520BDD2F.2060909@gmail.com>
References: <1375956979-31877-1-git-send-email-tangchen@cn.fujitsu.com> <20130812145016.GI15892@htj.dyndns.org> <52090225.6070208@gmail.com> <20130812154623.GL15892@htj.dyndns.org> <52090AF6.6020206@gmail.com> <20130812162247.GM15892@htj.dyndns.org> <520914D5.7080501@gmail.com> <20130812180758.GA8288@mtj.dyndns.org> <520BC950.1030806@gmail.com> <20130814182342.GG28628@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130814182342.GG28628@htj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: KOSAKI Motohiro <kosaki.motohiro@gmail.com>, Tang Chen <imtangchen@gmail.com>, Tang Chen <tangchen@cn.fujitsu.com>, robert.moore@intel.com, lv.zheng@intel.com, rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

(8/14/13 2:23 PM), Tejun Heo wrote:
> Hello,
>
> On Wed, Aug 14, 2013 at 02:15:44PM -0400, KOSAKI Motohiro wrote:
>> I don't follow this. We need to think why memory hotplug is necessary.
>> Because system reboot is unacceptable on several critical services. Then,
>> if someone set wrong boot option, systems SHOULD fail to boot. At that time,
>> admin have a chance to fix their mistake. In the other hand, after running
>> production service, they have no chance to fix the mistake. In general, default
>> boot option should have a fallback and non-default option should not have a
>> fallback. That's a fundamental rule.
>
> The fundamental rule is that the system has to boot.

I don't agree it. Please look at other kernel options. A lot of these don't
follow you. These behave as direction, not advise.

I mean the fallback should be implemented at turning on default the feature.


>  Your argument is
> pointless as the kernel has no control over where its own image is
> placed w.r.t. hotpluggable nodes.  So, are we gonna fail boot if
> kernel image intersects hotpluggable node and the option is specified
> even if memory hotplug can be used on other nodes?  That doesn't make
> any sense.

I don't read whole discussion and I don't quite understand why no kernel
place controlling is relevant. Every unpluggable node is suitable for
kernel. If you mean current kernel placement logic don't care plugging,
that's a bug.

If we aim to hot remove, we have to have either kernel relocation or
hotplug awre kernel placement at boot time.

> Failing to boot is *way* worse reporting mechanism than almost
> everything else.  If the sysadmin is willing to risk machines failing
> to come up, she would definitely be willing to check whether which
> memory areas are actually hotpluggable too, right?

No. see above. Your opinion is not pragmatic useful.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
