From: Andy Lutomirski <luto-YSGFQ8SKJZVDPfheJLI6IQ@public.gmane.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Sat, 12 Jul 2008 02:29:37 -0400
Message-ID: <48784F51.1010407@myrealbox.com>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu> <4869D4A3.3020000@zytor.com> <200807012239.44105.rjw@sisk.pl> <486A96C1.2020106@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <486A96C1.2020106-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

My Lenovo X61s fails to resume if I suspend it from within X, on both 
2.6.26-rc9 and recent wireless-testing.  2.6.26-rc8 is fine, as is 
wireless-testing with 4b4f7280 reverted.  My in-progress bisect between 
-rc8 and -rc9 is also consistent with this being the problem.

The symptom is that, when I push the power button to resume, the hard 
drive light turns on, the fan turns on, then the hard drive light turns 
off, the sleep light stays on, and the fan keeps running.  Sometimes the 
battery light will blink off very briefly (1/4 sec, maybe) every few 
seconds.  The system is locked hard at this point.

I'm using Ubuntu Hardy userspace.

--Andy

Andi Kleen wrote:
>> I have tested it on the nx6325 (64-bit) on top of the today's linux-next.  It
>> works fine for me.
> 
> Could a few more people with different laptops please test too?
> 
> -Andi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
