From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Subject: Re: Oopses and ACPI problems (Linus 2.6.29-rc4)
Date: Tue, 10 Feb 2009 14:12:44 +0000
Message-ID: <5030E21460%linux@youmustbejoking.demon.co.uk>
References: <alpine.LFD.2.00.0902081251090.3048@localhost.localdomain>
 <gemini.ket9w800w44dc0hvg.linux@youmustbejoking.demon.co.uk>
 <20090209234911.GB862@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:45757 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755075AbZBJOzL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Feb 2009 09:55:11 -0500
In-Reply-To: <20090209234911.GB862@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Corentin Chary <corentincj@iksaif.net>

[Adding Matthew Garrett & Corentin Chary to Cc]

I demand that Ingo Molnar may or may not have written...

> * Darren Salt <linux@youmustbejoking.demon.co.uk> wrote:
>> I'm seeing various oopses with -rc4, where -rc3 is fine; config, dme=
sg
>> (captured via netconsole) and decoded oops data attached =C2=B9. The=
 last few
>> oopses were followed by a scrambled display and a hard lockup.

>> All oopses follow an otherwise successful suspend-to-RAM.

> Various folks Cc:-ed. There's been a late, rather large ACPI merge, s=
o
> one post-rc3 suspect would be one of these commits:

[snip]
> 7695fb0: eeepc-laptop: fix oops when changing backlight brightness du=
ring
eeepc-laptop init

No, that one's harmless :-)

[snip]
> 2b25c9f: eeepc-laptop: use netlink interface

That one makes acpid (apparently) useless. The rest of the commit descr=
iption
is:
    To be prepared for /proc/acpi/event removal we export events
    also through generic netlink interface.

Note that "also". The actual effect of the patch is "instead".

Adding the two removed lines (but removing the post-increment of the ev=
ent
count) fixes this.

> 5740294: eeepc-laptop: Implement rfkill hotplugging in eeepc-laptop

Reverting this fixes the rfkill oops; things work correctly again. I do=
n't
know why this appears to be needed, since things work fine without this=
 patch
=E2=80=92 both Fn-F2 and echoing to /sys/class/rfkill/rfkill0/state =E2=
=80=92 even when I
start up with init=3D/bin/sh and test directly from that shell.

(901; BIOS rev. 1808.)

[snip]
> 2a7dc0d: asus-laptop: use generic netlink interface

That one also says "also" where it should say "instead" (not that it af=
fects
me).

=2E.. oh yes, there's a long delay between output of these two lines du=
ring
boot:
  input: ETPS/2 Elantech Touchpad as /class/input/input5
  eeepc: Hotkey init flags 0x41
(not seen in .28 or .28.1; not checked later .28.*.)

Anyway, a patch for the ACPI reporting problems will follow this messag=
e.

[snip]
--=20
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Output less CO2 =3D> avoid massive flooding.    TIME IS RUNNING OUT=
 *FAST*.

Life is that brief interlude between nothingness and eternity.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
