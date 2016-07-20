From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 1/7] x86, memhp, numa: Online memory-less nodes at boot
 time.
Date: Wed, 20 Jul 2016 10:28:29 +0800
Message-ID: <bd359a28-7187-cec7-e83b-f7444f1b09a6@cn.fujitsu.com>
References: <1468913288-16605-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1468913288-16605-2-git-send-email-douly.fnst@cn.fujitsu.com>
 <20160719185017.GM3078@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160719185017.GM3078@mtj.duckdns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: cl@linux.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

=E5=9C=A8 2016=E5=B9=B407=E6=9C=8820=E6=97=A5 02:50, Tejun Heo =E5=86=99=E9=
=81=93:

> Hello,
>
> On Tue, Jul 19, 2016 at 03:28:02PM +0800, Dou Liyang wrote:
>> In this series of patches, we are going to construct cpu <-> node mapp=
ing
>> for all possible cpus at boot time, which is a 1-1 mapping. It means t=
he
> 1-1 mapping means that each cpu is mapped to its own private node
> which isn't the case.  Just call it a persistent mapping?

Yes, for cpus, each cpu is in a persistent node.
However, the opposite is not that.

I will modify it.

Thanks.
Dou


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
