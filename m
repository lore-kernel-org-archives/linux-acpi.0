From: "John H." <mistamaila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Problems with Suspend-to-RAM
Date: Sat, 14 Jan 2006 22:43:33 -0600
Message-ID: <5b9417770601142043i2ed3fbfbm25b1171639e39c03@mail.gmail.com>
References: <5b9417770601141709kebcef60v1fb0f7d38cf885a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b9417770601141709kebcef60v1fb0f7d38cf885a7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: =?ISO-8859-1?Q?Jani-Matti_H=E4tinen?= <jani-matti.hatinen-X3B1VOXEql0@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hmm, using the video.txt you referenced, i noticed some of this is not
still applicable, like /proc/acpi/sleep
also, what is fedora equiv of rckbd?


#!/bin/bash
statedir=/root/s3/state
curcons=`fgconsole`
fuser /dev/tty$curcons 2>/dev/null|xargs ps -o comm= -p|grep -q X && chvt 2
cat /dev/vcsa >$statedir/vcsa
sync
echo "mem" > /sys/power/state
sync
vbetool post
vbetool vbestate restore <$statedir/vbe
cat $statedir/vcsa >/dev/vcsa
rckbd restart
chvt $[curcons%6+1]
chvt $curcons



On 1/14/06, John H. <mistamaila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> btw, how can i still have acpid running and use suspend to ram, as i
> had the same problem you described(power off on resume) until i turned
> off acpid.
>
>
> On 1/14/06, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wrote:
> > [trimmed Cc:, it's no longer related to acpi4asus]
> >
> > Thus wrote John H.:
> > > wow! i stopped acpid. and suspend didn't power off on resume from
> > > hitting one of the mm keys!
> > >
> > > the only problem is, the motor and stuff seems to resume, and it seems
> > > to try to read the cdrw drive again, and the various lights are on,
> > > but
> > >
> > > 1. i cannot use any key, even caps lock does not turn on
> >
> > Search acpi-devel archives, I believe this was reported recently.
> >
> > > 2. i see nothing on the display
> >
> > Documentation/power/video.txt
> > Best regards,
> >
> > --
> > Karol 'sziwan' Kozimor
> > sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
