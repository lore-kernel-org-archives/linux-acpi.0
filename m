From: Yinghai Lu <Yinghai.Lu@Sun.COM>
Subject: Re: [PATCH] x86: check boundary in count/setup_resource called by
 get_current_resources
Date: Thu, 01 Nov 2007 11:06:18 -0700
Message-ID: <472A159A.6080106@sun.com>
References: <200711010120.30410.yinghai.lu@sun.com>
 <20071101013239.992840bd.akpm@linux-foundation.org>
Reply-To: Yinghai.Lu@Sun.COM
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758747AbXKASDy@vger.kernel.org>
In-reply-to: <20071101013239.992840bd.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Gary Hade <gary.hade@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Andrew Morton wrote:
> On Thu, 01 Nov 2007 01:20:29 -0700 Yinghai Lu <Yinghai.Lu@Sun.COM> wrote:
> 
>> [PATCH] x86: check boundary in count/setup_resource called by get_current_resources
>>
>> need to check info->res_num less than PCI_BUS_NUM_RESOURCES, so
>> info->bus->resource[info->res_num] = res will not beyond of bus resource array
>> when acpi resutrn too many resource entries.
>>
> 
> Isn't this a bit of a problem?  It sounds like PCI_BUS_NUM_RESOURCES is to
> small for that system?  If so, some sort of dynamic allocation might be
> needed.

sound reasonable...
i have one local patch for amd64 that will get resources from pci conf. and it will use all 8 slots for bus 0.
and transparent bus under it only can copy 5 of them.

YH
