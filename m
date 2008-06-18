From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: linux-next Regression: Unable to locate IOAPIC
Date: Wed, 18 Jun 2008 13:41:00 -0700
Message-ID: <86802c440806181341w7c2ac2det817548c68d00040c@mail.gmail.com>
References: <200806051100.12885.dex@dragonslave.de>
	 <200806152114.33007.dex@dragonslave.de>
	 <86802c440806151220l358ca541s9d87fe2acc360e8@mail.gmail.com>
	 <200806182157.04120.dex@dragonslave.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756809AbYFRUlX@vger.kernel.org>
In-Reply-To: <200806182157.04120.dex@dragonslave.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: webmaster@dragonslave.de
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 18, 2008 at 12:57 PM, Daniel Exner <dex@dragonslave.de> wrote:
> Yinghai Lu wrote:
>> On Sun, Jun 15, 2008 at 12:14 PM, Daniel Exner <dex@dragonslave.de> wrote:
>> > Hi all,
>> >
>> > Yinghai Lu wrote:
>> >> >> To clarify myself:
>> >> >> 2.6.25.5:  --> relatively fast no IOAPIC Errors in dmesg
>> >> >> 2.6.26-rc5:   --> relatively  no IOAPIC Errors in dmesg
>> >> >> 2.6.26-rc5 + git-acpi Patch:   --> relatively  no IOAPIC Errors in
>> >> >> dmesg 2.6.26-rc5 +  linux-next snapshot 20080604 --> even slower than
>> >> >> before my ide Patch many "unable to locate IOAPIC" Errors
>> >> >>
>> >> >>
>> >> >> So I think the problem lies not in the acpi tree but somewhre else.
>> >> >>
>> >> >> Is it possible to tell git to explicitly _exclude_ a specific tree
>> >> >> while bisecting?
>> >>
>> >> can you check if the attached patch fix the problem?
>> >> it will not check entries before MP_intsrc_info...
>> >
>> > This fixed it, thanks :)
>> >
>> > Also maschine feels not as fast as with 2.6.25.x but noticeable faster :)
>> >
>> > I guss you no longer need the complete dmesg output?
>>
>> still need that... wonder why your irq routing have same entris from
>> your BIOS/ACPI?
> Again, sorry for the delay. I raised the Kernel buffer and added an output,
> done using rc6.
>

thanks for the dmesg

in dmesg
> Local APIC disabled by BIOS -- you can enable it with "lapic"

sound interesting...

YH
