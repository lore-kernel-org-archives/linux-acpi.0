From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] kaslr: get ACPI SRAT table to avoid movable memory
Date: Mon, 4 Sep 2017 16:17:28 +0800
Message-ID: <4f2f9d6e-8d6e-e518-bcb6-493d898b7341@cn.fujitsu.com>
References: <20170903143123.22031-1-fanc.fnst@cn.fujitsu.com>
 <2895411.GR6mzpbNLk@aspire.rjw.lan> <20170904022619.GB30906@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34551 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753283AbdIDIRi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Sep 2017 04:17:38 -0400
In-Reply-To: <20170904022619.GB30906@x1>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, arnd@arndb.de, dyoung@redhat.com, dave.jiang@intel.com, lv.zheng@intel.com, indou.takao@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, yasu.isimatu@gmail.com

Hi Rafael, Baoquan, and Chao,

At 09/04/2017 10:26 AM, Baoquan He wrote:
> On 09/04/17 at 12:55am, Rafael J. Wysocki wrote:
>> On Sunday, September 3, 2017 4:31:23 PM CEST Chao Fan wrote:
>>> KASLR should choose the memory region of immovable node to extract kernel.
>>> So get ACPI SRAT table and store the memory region of movable node which
>>> kaslr shold avoid.
>>
>> Please elaborate.
>>
>> This is far too little information on what problem you are trying to address

The problem is:

In X86 architecture, KASLR (Kernel Address Space Layout Randomization)
makes the memory hot-remove unhappy, when it extracts kernel into a
hot-removable memory region.

The reason is:

Linux cannot migrate the kernel pages, so memory used by the kernel
cannot be hot-removed. Normally, ACPI SRAT table records all
hotpluggable memory ranges. linux can use it to allocate memory
correctly.

But, When extracting kernel, SRAT is not parsed yet, KASLR doesn't
know which memory ranges are hotpluggable and should be avoid, So,
KASLR may randomize the kernel in movable memory, that makes the
movable memory can't hot-remove.

The original solution is:

Using "mem=" and "movable_node" in the kernel command line.

eg:

node 0 size: 1024 MB  immovable
node 1 size: 1024 MB  movable
node 2 size: 1024 MB  movable
node 3 size: 1024 MB  movable

Setting "mem=1024M movable_node", it will restrict the kernel physical
address to [0,1024M] for KASLR and will make sure the memory in node 1
, node 2, node 3 can be hot-removable.

But it has a problem:

if we bootup with all node, we just see 1G RAM, the kernel is not able
to see the whole system memory 4G. It is not good for us. So, we want
to extend the "movable_node" option to fix this problem.

The new ways in discussion are:

Method 1) As Chao's patch shows, Parse the ACPI SRAT table earlier
than extracting kernel.

Method 2) Extend movable_node option for KASLR, eg "movable_node=1024M"
   https://lkml.org/lkml/2017/8/3/401

>> and why you are trying to address it in this particular way.
>
> Agree with Rafael.
>
> Why don't you try specifying those regions in cmdline and process them
> in kaslr.c? Your colleague, Liyang has tried this way, just he only
> considered the region in the first node. In this way, you don't need to

No, not just the first node. It is based on a hypothesis that immovable
node has to be set from lowest address. eg:

node 0 size: 1024 MB  immovable
node 1 size: 1024 MB  immovable
node 2 size: 1024 MB  movable
node 3 size: 1024 MB  movable

With "movable_node=2048M" option in cmdline, KASLR will consider both
node1 and node2

Using method 2, "movable_node=1024M" can be regard as "mem=1024M
movable_node" except the limitation of memory.

the problem of the method 2 is that:

Using method 2, KASLR may not extract the kernel into all the immovable
memory. eg:

node 0 size: 1024 MB  immovable
node 1 size: 1024 MB  movable
node 2 size: 1024 MB  movable
node 3 size: 1024 MB  immovable

With "movable_node=1024M" option in cmdline, KASLR will can't access
the node3 memory.

I am looking for the solution of this. Not find a good way.

Sometimes, I will remember that proverb:

   You cannot have your cake and eat it too. :-)

Thanks,
	dou.
> touch ACPI tables with so many lines of code.
>
> Thanks
> Baoquan
>
>
>


