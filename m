From: "John H." <mistamaila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Acpi4asus-user] Asus S5000: Problems with Suspend-to-RAM
Date: Sat, 14 Jan 2006 18:07:46 -0600
Message-ID: <5b9417770601141607l6912c3f3wb160c29142b216e4@mail.gmail.com>
References: <200601142257.46188.jani-matti.hatinen@iki.fi>
	 <20060114230647.GA12613@hell.org.pl>
	 <5b9417770601141528h77410d57g9c9b6dbcbb2df72f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b9417770601141528h77410d57g9c9b6dbcbb2df72f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Jani-Matti_H=E4tinen?= <jani-matti.hatinen-X3B1VOXEql0@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: pavel-+ZI9xUNit7I@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

wow! i stopped acpid. and suspend didn't power off on resume from
hitting one of the mm keys!

the only problem is, the motor and stuff seems to resume, and it seems
to try to read the cdrw drive again, and the various lights are on,
but

1. i cannot use any key, even caps lock does not turn on
2. i see nothing on the display

I can eject the cd drive, if that means anything.

this is certainly better than it turning off, though.  how do i stop
it from turning off on resume if i have acpid running, and how do i
get my display and keys working?

thanks


On 1/14/06, John H. <mistamaila-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> i THINK that may be what is happening on my compaq 2110us as well, bu=
t
> i am not sure?
> when i try to resume from echo mem > /sys/power/state by hitting an
> acpi button, it seems for a split second it is resuming, but then
> powers off instantly.
>
> fc4
> acpid-1.0.4-1
>
>
>
> On 1/14/06, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> wrote:
> > Thus wrote Jani-Matti H=E4tinen:
> > > I have an Asus S5000 laptop and I have some problems with Suspend=
-to-RAM on
> > > it.
> > >   The laptop goes into suspend just fine, but on resume it immedi=
ately
> > > switches to runlevel 0 and goes down.
> >
> > You're getting spurious power button events, and since your acpid i=
s
> > configured to shut the system down on power button press, that's ex=
actly
> > what happens. Turn off acpid and try again or work it around in you=
r
> > scripts.
> >
> > BTW: This bug has been present since at least 2.5.7x, reported a co=
uple of
> > times, even tracked (http://bugme.osdl.org/show_bug.cgi?id=3D3525 i=
s the only
> > one I can find now, but I'm sure there are more). In spite of that,=
 it
> > occurs on every single machine I tested for S3. And contrary to wha=
t the
> > comments on #3525 say, it's definitely not a userspace issue, becau=
se the
> > power button event is sent *regardless* what triggered the wake-up,=
 be it a
> > keypress, lid event, one of the ACPI-controlled buttons or RTC alar=
m.
> >
> > Should I just reopen #3525 (it says Toshiba?) or file a new one?
> > Best regards,
> >
> > --
> > Karol 'sziwan' Kozimor
> > sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
