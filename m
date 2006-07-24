From: Thomas Renninger <trenn@suse.de>
Subject: Re: Linux kernel rebooting
Date: Mon, 24 Jul 2006 12:01:34 +0200
Message-ID: <1153735294.4302.56.camel@queen.suse.de>
References: <pan.2006.07.19.10.52.49.399303@tlen.pl>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:10971 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932102AbWGXJ67 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jul 2006 05:58:59 -0400
In-Reply-To: <pan.2006.07.19.10.52.49.399303@tlen.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-2?Q?=A3ukasz?= Jachymczyk <lfx@tlen.pl>
Cc: linux-acpi@vger.kernel.org

On Wed, 2006-07-19 at 12:52 +0200, =C5=81ukasz Jachymczyk wrote:
> Hello
>=20
> I've got a problem with rebooting my linux on laptop hp nx6310 (centr=
ino
> core duo). After restarting, bios hangs for a while and it runs slowe=
r
> then usual (up to 15 seconds until grub loads). After that, my linux =
works
> quite fine, however I'm not able to achieve maximym cpu speed with cp=
ufreq
> and acpi doesn't show actual information about battery left (it shows=
 all
> the time 2:30 hours left) - simply, acpi hangs in the moment of booti=
ng.
>=20
> But there is also ms windows on the same laptop. It reboots smoothly =
and
> quickly. There is no bios hanging effect. And after such reboot from
> windows, when I boot linux, everything works fine!
>=20
> I guess it's the problem of the way how linux' kernel with acpi reboo=
ts.
> Can somebody tell me what can I do with it? Maybe it's some kind of a=
 bug
> in acpi or kernel?
>=20
I think I identified two problems of your machine (on a HP nx9420):
Please have a look at:
https://bugzilla.novell.com/show_bug.cgi?id=3D179702

The battery issue should be related to ACPICA. Hmm, not sure whether
this is really fixed yet, could you try a kernel with latest ACPICA
patches in (try to use Len's ACPI test tree, not sure what is the lates=
t
ACPICA in there it should at least be 20060608).
If it does not work yet, please comment in the bug and I try to track i=
t
down.

The max_freq is never reached because _PPC always returns 1. I couldn't
identify what goes wrong inside there, this looks like a BIOS issue to
me and HP eventually takes care (already updated to latest BIOS? ->
better do that before starting anything else).

Would be nice if you can add a comment there (including your machine
model), this might help to get HP to have a look at it, they care about
Linux compatibility...

Thanks,

       Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
