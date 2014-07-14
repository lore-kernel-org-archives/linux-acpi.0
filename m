From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BISECTED 3.16-rc REGREGRESSION] backlight control stopped working
Date: Mon, 14 Jul 2014 15:19:22 -0700
Message-ID: <CA+55aFzNWehvLk2izhnXg--ghOgG7SfMzpzFJcbVZg9duGdWPQ@mail.gmail.com>
References: <87pph8kse7.fsf@nemi.mork.no>
	<53C3D7C3.7090505@redhat.com>
	<CA+55aFxYYKApOC+1TQkoxSzi-zTSB8OmkU=ypvNb_Gc2+K6Hmw@mail.gmail.com>
	<CA+55aFzHo4BEO8W0yza7g0YMgg-b=hPbk20-vpR3s==ydpmAOg@mail.gmail.com>
	<877g3fsm98.fsf@nemi.mork.no>
	<CA+55aFztNg4aFUnmqxoR-Hwva87D1TMOZ2Gyy8CVmEov9ToDQg@mail.gmail.com>
	<8761iztxzl.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8761iztxzl.fsf@nemi.mork.no>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: Hans de Goede <hdegoede@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 14, 2014 at 2:46 PM, Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>
> Yes, the patch works as advertised for me.  Thanks.

Ok, so it should probably be tested by people who see the "move by
two" problem too.

> But this will break existing configs:
>
> Any setup using e.g "options video brightness_switch_enabled=3DY" wil=
l
> barf on this, won't they?

Hmm. Probably. That said, that kind of breakage I think we might want
to live with, especially if it actually ends up causing them to test
the new default (which might just work for them).

But regardless, let's make sure that patch (or something _like_ it)
works for people who saw the reverse problem for you. Then the exact
syntax of whatever module parameter (if any) can be a separate
discussion.

Anyway, for 3.16 I think we should just do what we used to do (ie the
revert that Rafael apparently already has queued up), so this isn't
necessarily critical.

            Linus
