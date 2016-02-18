From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 RESEND 0/5] Make cpuid <-> nodeid mapping persistent
Date: Thu, 18 Feb 2016 03:11:46 +0100
Message-ID: <1672109.ebeP8evnQp@vostro.rjw.lan>
References: <1453702100-2597-1-git-send-email-tangchen@cn.fujitsu.com> <CAJZ5v0go7tZiDkh2novJKiDmYv_ge7Y-rQLC5ohRC=qSDJ+5-Q@mail.gmail.com> <56C525F9.1040107@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63047 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1423871AbcBRCKX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 21:10:23 -0500
In-Reply-To: <56C525F9.1040107@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, chen.tang@easystack.cn, cl@linux.com, Tejun Heo <tj@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>, mika.j.penttila@gmail.com, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, Len Brown <len.brown@intel.com>, x86@kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>

On Thursday, February 18, 2016 10:01:29 AM Zhu Guihua wrote:
> Hi Rafael,
> 
> On 02/03/2016 08:02 PM, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Wed, Feb 3, 2016 at 10:14 AM, Zhu Guihua <zhugh.fnst@cn.fujitsu.com> wrote:
> >> On 01/25/2016 02:12 PM, Tang Chen wrote:
> >>> Hi Rafael, Len,
> >>>
> >>> Would you please help to review the ACPI part of this patch-set ?
> >>
> >> Can anyone help to review this?
> > I'm planning to look into this more thoroughly in the next few days.
> 
> Were you reviewing this ?

Yes.

They generally look OK to me, but then I'd like the x86 maintainers to have
a look at them too.

There still are a few things I need to verify, but should be able to do that
by the end of this week.

Thanks,
Rafael

