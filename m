From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Tue, 01 Jul 2008 00:02:19 -0700
Message-ID: <4869D67B.4060902@zytor.com>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080701063133.GC16642-X9Un+BFzKDI@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ingo Molnar wrote:
> * Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> 
>> Hi,
>>
>> The appended patch fixes a regression and is considered as 2.6.26 
>> material. Everyone having a box with working suspend to RAM is gently 
>> requested to test it and verify if it doesn't break things.
>>
>> The patch applies to the current -git.
> 
> it's been under testing in tip/out-of-tree for about a week:
> 
> | commit ee901dc1b9ab94a37ba2efc296fe9ba72bc75adf
> | Author:     H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
> | AuthorDate: Tue Jun 24 23:03:48 2008 +0200
> | Commit:     Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>
> | CommitDate: Wed Jun 25 18:48:13 2008 +0200
> |
> |     x86 ACPI: normalize segment descriptor register on resume
> 
> no problems caused by it so far.
> 

It still seems incredibly risky to push this for 2.6.26, especially 
given the Elan revelation.  I think it needs to be tested on the 2.6.27 
track, and then possibly be pushed back via the 2.6.26-stable route.

	-hpa
