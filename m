From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [ltp] Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Tue, 10 Nov 2009 08:32:17 -0500
Message-ID: <cb0375e10911100532l484e69aeyd78e422c23d730ce@mail.gmail.com>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	 <20091109165420.GA28672@srcf.ucam.org>
	 <cb0375e10911090949o4a51cfd5x4f896d983398a7bc@mail.gmail.com>
	 <20091109175416.GA29887@srcf.ucam.org>
	 <20091110092418.GC1872@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:57579 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbZKJNcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2009 08:32:13 -0500
Received: by fxm21 with SMTP id 21so11861fxm.21
        for <linux-acpi@vger.kernel.org>; Tue, 10 Nov 2009 05:32:18 -0800 (PST)
In-Reply-To: <20091110092418.GC1872@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Nov 10, 2009 at 4:24 AM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Mon, 09 Nov 2009, Matthew Garrett wrote:
>> When you hit the mixer button, does the ACPI interrupt count increas=
e?
>> If so, we're certainly in a position to do something with it.
>
> It is supposed to go over the KDC. =A0But I would be _really_ interes=
ted on
> any events related to volume key presses on the X200s. =A0I expect it=
 is
> issuing one of the ACPI volume notification events with OSI(Linux), a=
nd none
> without.

On brief inspection, with OSI(Linux), mute generates no ACPI
interrupts.  Without OSI(Linux), I see an ACPI interrupt only when the
mixer (the one in /proc/acpi/ibm/volume) changes as a result of
muting.  So pushing mute once generates an interrupt, but then there
are no more interrupts until I push volume up.

>
>> But it does nothing to solve the underlying issue, and then we get t=
o
>> apply the same patch again for the next Thinkpad product cycle. If w=
e
>> fix it properly, we don't need to bother.
>
> If I get a full description of behaviour, etc. =A0I can simply ask Le=
novo
> about it.
>
> AFAIK, the native volume control through windows is being done in a
> different way, nowadays. =A0I'd need to know, without OSI(Linux), whe=
re the
> events are going. =A0That'd be enough to know when to read EC 0x30 an=
d check
> if it is now mute/unmute.

What's the point of the IBM mixer (/proc/acpi/ibm/volume)?  We have a
perfectly good mixer in the form of ALSA, which already knows how to
mute and unmute the sound and even comes with nice user interfaces
these days.

With OSI(Linux) off, pressing mute turns off the sound with no UI
response whatsoever, fiddling with the ALSA mixer (or PulseAudio, for
that matter) has no effect, and the only ways to get sound back are to
play with /proc/acpi/ibm/volume or to press a different hardware
volume key.  But pressing that different hardware volume key *also*
changes the ALSA mixer because it generates a keypress.  In my book,
that means that the mute button messes up the sound hardware.

Do we really want every thinkpad to need a special UI to indicate the
state of the extra hardware muting function?

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
