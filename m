From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH] acpi-video: Fix backlight taking 2 steps on a brightness key press
Date: Wed, 16 Jul 2014 14:03:54 +0200
Message-ID: <87wqbdecid.fsf@nemi.mork.no>
References: <1405509908-12620-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:59115 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932824AbaGPMFS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jul 2014 08:05:18 -0400
In-Reply-To: <1405509908-12620-1-git-send-email-hdegoede@redhat.com> (Hans de
	Goede's message of "Wed, 16 Jul 2014 13:25:07 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> Hi All,
>
> Here is my cleaned-up version of Linus' patch to fix the 2 steps on a
> brightness key press problem.
>
> Changes compared to Linus' version:
> -Move the global variables to inside struct acpi_video_device
> -Rebase on top of Rafael's linux-pm linux-next branch (so on top of t=
he
>  revert of changing the brightness_switch_enabled default)
>
> I've tested this on a laptop affected by the 2 steps problem and I ca=
n confirm
> that it fixes the 2 steps issue under normal usage. I managed to trig=
ger the
> race by generating a heavy io-load, as exptected hitting the race has=
 no
> unwanted side-effects other then taking 2 steps instead of one.
>
> Bj=C3=B8rn can you test this patch on your system and confirm that it=
 does not
> break things for you please ? Note that in order to apply it you firs=
t need
> to do: "git revert 886129a8eebebec", as the revert has not yet reache=
d
> Linus' tree AFAIK.

Tested and verified that it still works fine for me, so feel free to ad=
d

Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>

if you like.

But as noted earlier, I believe this poses another risk if anyone has a
config using bool input values:

-static bool brightness_switch_enabled =3D 1;
-module_param(brightness_switch_enabled, bool, 0644);
+static int brightness_switch_enabled =3D -1;
+module_param(brightness_switch_enabled, int, 0644);


I wonder if it wouldn't be better to just redefine the behaviour of
"brightness_switch_enabled =3D 1" to the new delayed response scheme an=
d
avoid changing the type of this parameter?



Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
