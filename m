From: Hans Reiser <reiser-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re. 2.6.15-mm1
Date: Fri, 06 Jan 2006 01:30:22 -0800
Message-ID: <43BE38AE.80203@namesys.com>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org> <20060105144720.25085afa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060105144720.25085afa.akpm-3NddpPZAyC0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Vladimir V. Saveliev" <vs-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>, Alexander Zarochentcev <zam-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andrew Morton wrote:

>
>
>  
>
>>When X startet, the laptops crashed:
>>Jan  5 16:22:43 t40 kernel: <4>reiser4[syslogd(2729)]: disable_write_barrier 
>>(fs/reiser4/wander.c:233)[zam-1055]:
>>Jan  5 16:22:43 t40 kernel: WARNING: disabling write barrier
>>    
>>
>
>Vladimir, is that expected?
>  
>
Vladimir is in France skiing, as this is Russian Christmas right now. 

Zam says that this merely means that the underlying device does not
support write barriers, and the code uses synchronous writes for commits
instead of write barriers when this happens.  It should not affect
correctness.  He will comment more this evening (russian time) when he
gets home.   He suggests that he should change it from warning to
notice.  He also suggests that this code is new code, so it is possible
it has bugs.....

>  
>
>>Jan  5 16:22:43 t40 kernel:
>>Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing 
>>0xe0000000,0x4000000
>>Jan  5 16:22:48 t40 last message repeated 2 times
>>    
>>
>
>Is that new?
>
>  
>
>>Jan  5 16:22:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at 
>>0000:00:00.0.
>>Jan  5 16:22:48 t40 kernel: c028b7cf
>>Jan  5 16:22:48 t40 kernel: Modules linked in: irtty_sir sir_dev cfq_iosched 
>>ehci_hcd uhci_hcd
>>Jan  5 16:22:48 t40 kernel: EIP:    0060:[<c028b7cf>]    Not tainted VLI
>>Jan  5 16:22:48 t40 kernel: EFLAGS: 00013202   (2.6.15-mm1)
>>Jan  5 16:22:48 t40 kernel:        <0>c028b9e9 f762ff08 00000002 00000000 
>>c19720ec 00000000 1f000217 c1a79400
>>Jan  5 16:22:48 t40 kernel:        <0>00000032 00000001 c028bfb5 c0297262 
>>c1a79400 c02972af 1f000207 c029727f
>>    
>>
>
>hm, it's not clear what oopsed.   Can you get a cleaner copy of this?
>
>  
>
>>Jan  5 16:22:48 t40 kernel:  <3>[drm:drm_release] *ERROR* Device busy: 1 0
>>    
>>
>
>drm is unhappy
>
>
>
>  
>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
