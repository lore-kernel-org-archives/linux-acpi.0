From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] acpi-video: Fix backlight taking 2 steps on a brightness
 key press
Date: Wed, 16 Jul 2014 16:32:36 +0200
Message-ID: <53C68D04.2030307@redhat.com>
References: <1405509908-12620-1-git-send-email-hdegoede@redhat.com> <87wqbdecid.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19257 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965109AbaGPOc4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 10:32:56 -0400
In-Reply-To: <87wqbdecid.fsf@nemi.mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org

Hi,

On 07/16/2014 02:03 PM, Bj=C3=B8rn Mork wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>=20
>> Hi All,
>>
>> Here is my cleaned-up version of Linus' patch to fix the 2 steps on =
a
>> brightness key press problem.
>>
>> Changes compared to Linus' version:
>> -Move the global variables to inside struct acpi_video_device
>> -Rebase on top of Rafael's linux-pm linux-next branch (so on top of =
the
>>  revert of changing the brightness_switch_enabled default)
>>
>> I've tested this on a laptop affected by the 2 steps problem and I c=
an confirm
>> that it fixes the 2 steps issue under normal usage. I managed to tri=
gger the
>> race by generating a heavy io-load, as exptected hitting the race ha=
s no
>> unwanted side-effects other then taking 2 steps instead of one.
>>
>> Bj=C3=B8rn can you test this patch on your system and confirm that i=
t does not
>> break things for you please ? Note that in order to apply it you fir=
st need
>> to do: "git revert 886129a8eebebec", as the revert has not yet reach=
ed
>> Linus' tree AFAIK.
>=20
> Tested and verified that it still works fine for me, so feel free to =
add
>=20
> Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> if you like.
>

Thanks, if there is a need for a v2 I'll add your tested-by.

Rafael, if there is not going to be a v2, could you pick up this tested=
-by
then?

> But as noted earlier, I believe this poses another risk if anyone has=
 a
> config using bool input values:
>=20
> -static bool brightness_switch_enabled =3D 1;
> -module_param(brightness_switch_enabled, bool, 0644);
> +static int brightness_switch_enabled =3D -1;
> +module_param(brightness_switch_enabled, int, 0644);
>=20

The only way I can see that being a problem is if someone is using
video.brightness_switch_enabled=3DN for reasons other then the 2 step
problem this patch fixes. That is not unthinkable though.

> I wonder if it wouldn't be better to just redefine the behaviour of
> "brightness_switch_enabled =3D 1" to the new delayed response scheme =
and
> avoid changing the type of this parameter?

I think that is a good idea, that would also allow to simplify the patc=
h
somewhat more. Rafael, what is your take on this ?

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
