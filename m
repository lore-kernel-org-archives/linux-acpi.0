From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 RESEND 0/5] Make cpuid <-> nodeid mapping persistent
Date: Wed, 3 Feb 2016 11:42:49 -0500
Message-ID: <20160203164249.GG14091@mtj.duckdns.org>
References: <1453702100-2597-1-git-send-email-tangchen@cn.fujitsu.com>
 <56A5BCDB.4090208@cn.fujitsu.com>
 <56B1C504.4060905@cn.fujitsu.com>
 <CAJZ5v0go7tZiDkh2novJKiDmYv_ge7Y-rQLC5ohRC=qSDJ+5-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0go7tZiDkh2novJKiDmYv_ge7Y-rQLC5ohRC=qSDJ+5-Q@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, chen.tang@easystack.cn, cl@linux.com, Jiang Liu <jiang.liu@linux.intel.com>, mika.j.penttila@gmail.com, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "H. Peter Anvin" <hpa@zytor.com>, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, Len Brown <len.brown@intel.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>
List-Id: linux-acpi@vger.kernel.org

Hello,

This also made workqueue blow up when delayed modding races cpu
offlining.

 http://lkml.kernel.org/g/1454424264.11183.46.camel@gmail.com

I'll work around it from the queueing path but it'd be great if the
mapping can be made stable sooner than later.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
