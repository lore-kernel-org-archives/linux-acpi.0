From: dagit@codersbase.com
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: [ACPI] Resume from Suspend to RAM))
Date: Tue, 14 Jun 2005 15:01:06 -0700
Message-ID: <87u0k061jx.fsf@www.codersbase.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
	<87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz>
	<87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261369AbVFNWBO@vger.kernel.org>
In-Reply-To: <20050614213728.GB2172@elf.ucw.cz> (Pavel Machek's message of
 "Tue, 14 Jun 2005 23:37:28 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at, acpi-dev <acpi-devel@lists.sourceforge.net>, Matthew Garrett <mjg59@srcf.ucam.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> > You got this wrong. It is three illegal instructions but
>> > *nested*. Like error, error in fault handler, error in doublefault
>> > handler.
>> 
>> Ah.  Yeah, this isn't an area I know much about :)  Thanks for the
>> correction. 
>> 
>> > Try replacing flags manipulation with any stack manipulation to see
>> > what is wrong.
>> 
>> Do you mean try something like this? Replace the push 0 with push
>> 0x1234 ; push 0x1234 ; pop ; pop and try to figure out which line
>> causes the reboot?
>
> Yep, try pushl $0, popl %eax; if that causes problems, something is
> seriously wrong with stack, otherwise changing flags hurts.

pushl $0, popl %eax gets the reboot.  So it's changing the flags that
is bad?

What should we try next?

thanks,
Jason
