From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [Acpi4asus-user] Asus S5000: Problems with Suspend-to-RAM
Date: Sun, 15 Jan 2006 00:06:48 +0100
Message-ID: <20060114230647.GA12613@hell.org.pl>
References: <200601142257.46188.jani-matti.hatinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200601142257.46188.jani-matti.hatinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jani-Matti =?iso-8859-2?Q?H=E4tinen?= <jani-matti.hatinen-X3B1VOXEql0@public.gmane.org>
Cc: acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Jani-Matti H=E4tinen:
> I have an Asus S5000 laptop and I have some problems with Suspend-to-=
RAM on=20
> it.
>   The laptop goes into suspend just fine, but on resume it immediatel=
y=20
> switches to runlevel 0 and goes down.

You're getting spurious power button events, and since your acpid is
configured to shut the system down on power button press, that's exactl=
y
what happens. Turn off acpid and try again or work it around in your
scripts.

BTW: This bug has been present since at least 2.5.7x, reported a couple=
 of
times, even tracked (http://bugme.osdl.org/show_bug.cgi?id=3D3525 is th=
e only
one I can find now, but I'm sure there are more). In spite of that, it
occurs on every single machine I tested for S3. And contrary to what th=
e
comments on #3525 say, it's definitely not a userspace issue, because t=
he
power button event is sent *regardless* what triggered the wake-up, be =
it a
keypress, lid event, one of the ACPI-controlled buttons or RTC alarm.

Should I just reopen #3525 (it says Toshiba?) or file a new one?
Best regards,

--=20
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
