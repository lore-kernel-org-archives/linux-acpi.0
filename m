From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 1/5] x86, gfp: Cache best near node for memory allocation.
Date: Wed, 12 Aug 2015 09:53:51 +0800
Message-ID: <55CAA72F.8050308@linux.intel.com>
References: <1436261425-29881-1-git-send-email-tangchen@cn.fujitsu.com>
 <1436261425-29881-2-git-send-email-tangchen@cn.fujitsu.com>
 <20150715214802.GL15934@mtj.duckdns.org> <55C03332.2030808@cn.fujitsu.com>
 <55C0725B.80201@linux.intel.com> <55C6EFFF.5070605@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4229 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411AbbHLBx4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Aug 2015 21:53:56 -0400
In-Reply-To: <55C6EFFF.5070605@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>, Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, laijs@cn.fujitsu.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On 2015/8/9 14:15, Tang Chen wrote:
> Hi Liu,
> 
> Have you posted your new patches ?
> (I mean memory-less node support patches.)
Hi Chen,
	I have rebased my patches to v4.2-rc4, but unfortunately
it breaks. Seems there are some changes in x86 NUMA support since
3.17. I need some time to figure it out.

> 
> If you are going to post them, please cc me.
Sure.

> 
> And BTW, how did you reproduce the memory-less node problem ?
> Do you have a real memory-less node on your machine ?
Yes, we have a system with memoryless nodes.
Thanks!
Gerry
