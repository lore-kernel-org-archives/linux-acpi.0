From: "John H." <mistamaila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Problems with Suspend-to-RAM
Date: Sat, 14 Jan 2006 19:09:25 -0600
Message-ID: <5b9417770601141709kebcef60v1fb0f7d38cf885a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: =?ISO-8859-1?Q?Jani-Matti_H=E4tinen?= <jani-matti.hatinen-X3B1VOXEql0@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

btw, how can i still have acpid running and use suspend to ram, as i
had the same problem you described(power off on resume) until i turned
off acpid.


On 1/14/06, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wrote:
> [trimmed Cc:, it's no longer related to acpi4asus]
>
> Thus wrote John H.:
> > wow! i stopped acpid. and suspend didn't power off on resume from
> > hitting one of the mm keys!
> >
> > the only problem is, the motor and stuff seems to resume, and it seems
> > to try to read the cdrw drive again, and the various lights are on,
> > but
> >
> > 1. i cannot use any key, even caps lock does not turn on
>
> Search acpi-devel archives, I believe this was reported recently.
>
> > 2. i see nothing on the display
>
> Documentation/power/video.txt
> Best regards,
>
> --
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
