From: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: [2.6.25-rc5-mm1] BUG: spinlock bad magic early during boot
Date: Thu, 27 Mar 2008 10:23:56 +0100
Message-ID: <47EB67AC.4090309@aitel.hist.no>
References: <1205517802.12763.18.camel@nimitz.home.sr71.net>	 <1205525184.12763.32.camel@nimitz.home.sr71.net>	 <47DAE55C.3080506@tremplin-utc.net>	 <1205530551.8167.20.camel@nimitz.home.sr71.net>	 <47DB013D.3060102@tremplin-utc.net>	 <1205537395.8167.31.camel@nimitz.home.sr71.net> <47DBC578.7050101@imap.cc>	 <alpine.LFD.1.00.0803151212180.3020@woody.linux-foundation.org>	 <47DC26BC.7060502@tremplin-utc.net>	 <alpine.LFD.1.00.0803151315250.3020@woody.linux-foundation.org>	 <20080321131737.GC5331@ucw.cz> <1206288004.30471.45.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758983AbYC0JUE@vger.kernel.org>
In-Reply-To: <1206288004.30471.45.camel@nimitz.home.sr71.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, ?ric Piel <Eric.Piel@tremplin-utc.net>, Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>, Christoph Hellwig <hch@infradead.org>, Markus Gaugusch <dsdt@gaugusch.at>, linux-acpi@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Arjan van de Ven <arjanv@redhat.com>, Eric Biederman <ebiederm@xmission.com>
List-Id: linux-acpi@vger.kernel.org

Dave Hansen wrote:
> On Fri, 2008-03-21 at 14:17 +0100, Pavel Machek wrote:
>   
>>> So what's the reason for pushing for this insanely-early workaround in the 
>>> first place, instead of letting user-space do something like
>>>
>>>       cat my-dsdt-image > /proc/sys/acpi/DSDT
>>>
>>> or whatever at runtime?
>>>       
>> You have interpretted code runing (AML), and you want to replace it
>> with different code?
>>
>> Akin to changing from one kernel to different during runtime?
>>     
>
> Heh.  That gave me an idea.
>
> Can we use kexec for this?  Let's say you get as far in boot as the
> initrd and realize that you're running on one of these screwed up
> systems.  Can you stick the new DSDT somewhere known (and safe) in
> memory, and kexec yourself back to the beginning of the kernel boot?
>
> When you boot up the second time, you have the new, shiny DSDT there
> which is, of course, used instead of the bogus BIOS one.
>   
I see a problem here. 
This could work. And if it is successful, the "kexec reboot around 
busted hw"-trick
is used for other stuff as well.

So your broken machine reboots with some fix, then it reboots with the
custom DSDT. Is the previous fix preserved? Then a third problem is hit,
another kexec reboot. Is the first fix _and_ the custom DSDT
preserved on this reboot?  Or do we get an infinite sequence of reboots,
alternating between a couple of completely unrelated fixes for bad 
hw/bios...

Once there is more than one fix utilizing this trick, some "protocol" for
managing a string of  kexec fixes might become necessary.

Helge Hafting
