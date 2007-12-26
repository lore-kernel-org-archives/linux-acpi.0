From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Suspend code ordering (again)
Date: Wed, 26 Dec 2007 18:24:06 +0300
Message-ID: <47727216.4050003@gmail.com>
References: <200712231419.40207.carlos@strangeworlds.co.uk> <200712251713.13223.rjw@sisk.pl> <alpine.LFD.0.9999.0712252006330.21557@woody.linux-foundation.org> <200712261607.18429.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752503AbXLZPYZ@vger.kernel.org>
In-Reply-To: <200712261607.18429.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, "H. Peter Anvin" <hpa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday, 26 of December 2007, Linus Torvalds wrote:
>   
>> On Tue, 25 Dec 2007, Rafael J. Wysocki wrote:
>>     
>>> the ACPI specification between versions 1.0x and 2.0.  Namely, while ACPI
>>> 2.0 and later wants us to put devices into low power states before calling
>>> _PTS, ACPI 1.0x wants us to do that after calling _PTS.  Since we're following
>>> the 2.0 and later specifications right now, we're not doing the right thing for
>>> the (strictly) ACPI 1.0x-compliant systems.
>>>
>>> We ought to be able to fix things on the high level, by calling _PTS earlier on
>>> systems that claim to be ACPI 1.0x-compliant.  That will require us to modify
>>> the generic susped code quite a bit and will need to be tested for some time.
>>>       
>> That's insane. Are you really saying that ACPI wants totally different 
>> orderings for different versions of the spec?
>>     
>
> Yes, I am.
>
>   
>> And does Windows really do that?
>>     
>
> I don't know.
>   
Windows was compliant only with 1.x spec until Vista.
With Vista claims are 3.x compliance.

