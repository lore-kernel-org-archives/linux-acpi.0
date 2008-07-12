From: Andy Lutomirski <luto-YSGFQ8SKJZVDPfheJLI6IQ@public.gmane.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Sat, 12 Jul 2008 11:08:05 -0400
Message-ID: <4878C8D5.9030707@myrealbox.com>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu> <4869D4A3.3020000@zytor.com> <200807012239.44105.rjw@sisk.pl> <486A96C1.2020106@firstfloor.org> <48784F51.1010407@myrealbox.com> <48789EC3.2070701@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <48789EC3.2070701-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andi Kleen wrote:
> Andy Lutomirski wrote:
>> My Lenovo X61s fails to resume if I suspend it from within X, on both
>> 2.6.26-rc9 and recent wireless-testing.  2.6.26-rc8 is fine, as is
>> wireless-testing with 4b4f7280 reverted.  My in-progress bisect between
>> -rc8 and -rc9 is also consistent with this being the problem.
> 
> With "this" do you mean the patch being applied or not applied?
> 
> As in does it fail with the patch applied?
> 
> You can confirm that by only applying the patch and testing.

The tree as of 4b4f2780 (the title patch of this thread) fails to 
resume.  Its parent works fine.  Which makes this patch the culprit.  (I 
just tried both.)

--Andy
