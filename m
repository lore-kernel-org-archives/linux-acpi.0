From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] Updated patches for PCI IRQ resource deallocation
 support [2/3]
Date: Wed, 29 Sep 2004 09:41:46 +0900
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <415A04CA.1080504@jp.fujitsu.com>
References: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251416570.2908@musoma.fsmlabs.com>
 <4157A9D7.4090605@jp.fujitsu.com>
 <Pine.LNX.4.61.0409281702580.3052@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-reply-to: <Pine.LNX.4.61.0409281702580.3052@musoma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, long <tlnguyen@snoqualmie.dp.intel.com>, Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>, tony.luck@intel.com, acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Zwane Mwaikambo wrote:
> On Mon, 27 Sep 2004, Kenji Kaneshige wrote:
> 
>> > > Why not just make these static inlines in header files? Since you're on
>> > > this, how about making irq_desc and friends dynamic too?
>> 
>> I'm not quite sure what you are saying, but my idea is defining
>> acpi_unregister_gsi() as a opposite part of acpi_register_gsi().
>> Acpi_register_gsi() is defined for each arch (i386, ia64), so
>> acpi_unregister_gsi() is defined for each i386 and ia64 too. 
> 
> Well i meant can't you define them in a header file as follows;
> 
> static void inline acpi_unregister_gsi (unsigned int irq)
> {
> }
> 
> An advantage is that it saves memory since you don't also have to create 
> the extra data objects for the exported symbol. But really you don't have 
> to export something which does nothing.
> 
Hi Zwane,

I understand what you mean. It looks good to me.
I'll update my patch.

Thanks,
Kenji Kaneshige

