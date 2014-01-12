From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 2/2] x86, e820 disable ACPI Memory Hotplug if memory mapping
 is specified by user [v2]
Date: Sun, 12 Jan 2014 18:46:42 -0500
Message-ID: <52D32962.5050908@redhat.com>
References: <1389380698-19361-1-git-send-email-prarit@redhat.com> <1389380698-19361-4-git-send-email-prarit@redhat.com> <alpine.DEB.2.02.1401111624170.20677@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.DEB.2.02.1401111624170.20677@be1.lrz>
Sender: owner-linux-mm@kvack.org
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linn Crosetto <linn@hp.com>, Pekka Enberg <penberg@kernel.org>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Tang Chen <tangchen@cn.fujitsu.com>, Wen Congyang <wency@cn.fujitsu.com>, Vivek Goyal <vgoyal@redhat.com>, kosaki.motohiro@gmail.com, dyoung@redhat.com, linux-acpi@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org



On 01/11/2014 11:35 AM, 7eggert@gmx.de wrote:
> 
> 
> On Fri, 10 Jan 2014, Prarit Bhargava wrote:
> 
>> kdump uses memmap=exactmap and mem=X values to configure the memory
>> mapping for the kdump kernel.  If memory is hotadded during the boot of
>> the kdump kernel it is possible that the page tables for the new memory
>> cause the kdump kernel to run out of memory.
>>
>> Since the user has specified a specific mapping ACPI Memory Hotplug should be
>> disabled in this case.
> 
> I'll ask just in case: Is it possible to want memory hotplug in spite of 
> using memmap=exactmap or mem=X?

Good question -- I can't think of a case.  When a user specifies "memmap" or
"mem" IMO they are asking for a very specific memory configuration.  Having
extra memory added above what the user has specified seems to defeat the purpose
of "memmap" and "mem".

P.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
