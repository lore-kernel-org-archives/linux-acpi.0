From: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Tue, 01 Jul 2008 18:21:11 +0200
Message-ID: <486A5977.8020905@firstfloor.org>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu> <4869D67B.4060902@zytor.com> <486A2AC3.2060107@firstfloor.org> <486A5378.7020601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <486A5378.7020601-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

H. Peter Anvin wrote:
> Andi Kleen wrote:
>>> It still seems incredibly risky to push this for 2.6.26, especially
>>> given the Elan revelation.
>>
>> Do Elans even support S3?
> 
> I don't know if they do, but I don't know offhand the extent of machines
> that may have that problem, especially since Intel now document it as
> "failures are readily seen".

What document is that exactly?


> 
>>>  I think it needs to be tested on the 2.6.27
>>> track, and then possibly be pushed back via the 2.6.26-stable route.
>>
>> I'm just not sure how many suspend/resume cycles people really do
>> on a early (pre -rc) mainline kernel (or in linux-next for that
>> matter). You usually have to install on a laptop and actually
>> use it.
>>
>> Since this code is only executed on resume some directed testing
>> would be better. That is what Rafael asked for in this mail.
> 
> The issue is mostly if it breaks some obscure system.  I have put it on
> my laptop, Ingo has it on this test system with a suspend-testing cycle,
> and so on, but the number of systems exposed is going to be small.

Right now it looks like a significant number of Dell laptops
are affected by this regression. That's a serious issue.

-Andi
