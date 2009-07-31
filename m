From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan-caicS1wCkhO6A22drWdTBw@public.gmane.org>
Subject: Re: [Bug #13471] Loading parport_pc kills the keyboard if ACPI is
 enabled
Date: Fri, 31 Jul 2009 18:08:24 +0300
Message-ID: <4A7308E8.1000200@pardus.org.tr>
References: <DizPU9GBfHF.A.kgF.iWObKB@chimera>	<H5-1lZIIeYK.A.dWH.9XObKB@chimera> <20090731151417.568094e5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090731151417.568094e5-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Alan Cox wrote:
> On Sun, 26 Jul 2009 22:45:29 +0200 (CEST)
> "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
>
>   
>> This message has been generated automatically as a part of a report
>> of regressions introduced between 2.6.29 and 2.6.30.
>>
>> The following bug entry is on the current list of known regressions
>> introduced between 2.6.29 and 2.6.30.  Please verify if it still should
>> be listed and let me know (either way).
>>     
>
>
> Ozan - can you confirm it broke between 2.6.29 (ie you tested 2.6.29),
> and 2.6.30-rc1. If so I have an idea what is going on
>   

>From my last comment on bugzilla.kernel.org:

"I tried with 2.6.30.1 but the problem still persists. I really don't have time
to bisect it, but I can help with any other debugging outputs. I also started
think that my board could somehow be faulty as no other people complains about
a similar issue.

Finally, it seems that the problem is available with 2.6.28, so the starting
point is still fuzzy to me. I remember that the keyboard was working OK with
2.6.29_rc7 but now it's not.

Maybe we should drop this report from the regression list."


Monday I'll have access to the computer. I'll build and try to find the last working version.
Meanwhile, I'd like to hear about your possible finding.

Thanks,
