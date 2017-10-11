From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [POC] Extend "movable_node" to "movable_node=nn@ss" and add the
 interface in /sys to show the value
Date: Wed, 11 Oct 2017 17:14:52 +0800
Message-ID: <20171011091452.GB15263@localhost.localdomain>
References: <20171011022827.GD13296@localhost.localdomain>
 <20171011075513.GA9142@x1>
 <20171011082319.GA15263@localhost.localdomain>
 <20171011084215.GB9142@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171011084215.GB9142@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org, arnd@arndb.de, dyoung@redhat.com, dave.jiang@intel.com, lv.zheng@intel.com, rjw@rjwysocki.net, yasu.isimatu@gmail.com, caoj.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 11, 2017 at 04:42:15PM +0800, Baoquan He wrote:
>Hi dear Fan San,
Hi dear Uncle Bao,

>
>On 10/11/17 at 04:23pm, Chao Fan wrote:
>> On Wed, Oct 11, 2017 at 03:55:13PM +0800, Baoquan He wrote:
>> >Hi Fan San,
>> >> 1. Get and parse the srat table before kernel extracted, then mark the memory
>> >>    region in movable node which should be avoided in kaslr.
>> >>    I have send the patch:
>> >>    https://www.spinics.net/lists/kernel/msg2595546.html
>> >>    But the change is large and then here is the second method.
>> >> 
>> >> 2. Extend the movable_node to movable_node=nn@ss, in which nn means
>> >>    the size of memory in immovable node, and ss means the start position of
>> >>    this memory region.
>> >>    But it brings another question, it may be a little difficult for a normal
>> >>    user to specify the nn and ss. Because it's hard for a user to know the value
>> >>    of the memory in immovable node.
>> >>    So I wonder if it's good to add a interface in /sys, like:
>> >>    # cat /sys/device/system/memory/immovable_node
>> >
>> Hi Baoquan,
>> 
>> Thanks for your reply,
>> 
>> >You can post patch. By the way, can the existing
>> >/sys/devices/system/memory/memoryX/removable be used instead?
>> 
>> I ever search the interfaces of /sys/devices/system/memory/, and noticed
>> this "removable", it does be able to help us judge it's removable or not.
>> But we should also get the information of the memory length and start position
>> by other interface. If there is a interface that show the nn and ss, we
>> can use them and change grub directly.
>> And there are more "memoryX" in one node. In my machine, I can see
>> memory0(linked to /sys/devices/system/memory/memory0) - memory7 in
>> /sys/devices/system/node/node0. And total memory38 for 4 nodes. I think
>> it's a little heavy to handle every memoryX.
>> But in SRAT table, one node has one or two memory regions. So I thinks
>> it's more straight and easy to use. How do you think about it?
>
>I am fine, I just mention it.

OK, I just explain I did not find  the suitable existing interface.

>
>Then please show your code envelopped in well formatted patch.

OK, will try to make it.

Thanks,
Chao Fan
>
>Thanks
>Baoquan
>
>> >
>> >>    nn@ss
>> >>    nn@ss
>> >>    ...
>> >>    to show the two value.
>> >>    When srat table is parsed in acpi_parse_memory_affinity, fill the value
>> >>    and user can get and use them.
>> >> 
>> >> If anyone has a better method, please let me know.
>> >> Any comments will be welcome.
>> >> 
>> >> Thanks,
>> >> Chao Fan
>> >> 
>> >> 
>> >
>> >
>> 
>> 
>
>
