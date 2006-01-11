From: "Mattia Dongili" <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
Date: Wed, 11 Jan 2006 15:27:40 +0100 (CET)
Message-ID: <15632.83.103.117.254.1136989660.squirrel@picard.linux.it>
References: <20060110235554.GA3527@inferi.kami.home>
    <20060110170037.4a614245.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060110170037.4a614245.akpm-3NddpPZAyC0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-dev-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, January 11, 2006 2:00 am, Andrew Morton said:
> Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org> wrote:
[...]
>> 3- This laptop experienced 2 long stalls (20~25 sec) during boot,
>>    apparently after scanning usb_storage devices and starting portmap.
>
> You mean before starting portmap?

well, _while_ starting portmap. As you can see from the traces I have
portmap sleeping in sys_poll, consider my reflexes are not that fast
so the trace might be well more than 10 secs after the /etc/init.d/portmap
was run.
Trying to stop and start it again didn't have any delay.

>>    Is it time for me to learn to git bisect? (Tomorrow morning I'll try
>>    (CET) if plain 2.6.15 also shows the same stalls).
>
> Please test the next Linus git tree (2.6.15-git7) and see if we've
> propagated it into there too.
>
> There's not much point in fiddling with -mm2.  If git7 is OK then please
> test the next -mm and if it still fails then yes, doing a bisection would
> really help.
>
> <types madly>
>
> See http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt

ooooh :) really really thanks!!
I was starting to script something that just some hours later revealed to
be like stGit (well at least had the same base idea).

Anyway I'm currently using -git7 and building -mm3, -git7 is OK:
no stalls, no reiser3 oops (yet) and no ACPI misaligned pointer.

Will report on -mm3 as soon as possible

-- 
mattia
:wq!


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
