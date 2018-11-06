From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Tue, 6 Nov 2018 12:34:25 -0800
Message-ID: <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
References: <20181103065732.12134-1-jprvita@endlessm.com> <20181105091917.GD4439@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105091917.GD4439@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2018-11-02 23:57:32, Jo=C3=A3o Paulo Rechi Vita wrote:
> > Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
> > "Discharging" on some machines when AC was connected but the battery wa=
s
> > not charging. But now on these machines the battery status is reported
> > as "Not charging" even when the battery is fully charged.
> >
> > This commit takes the battery capacity into consideration when checking
> > if "Not charging" should be returned and "Full" is returned when the
> > capacity is 100%.
> >
> > Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
>
> We have people trying to modify this and it caused regressions in
> MATE, IIRC.
>

Do you have any pointers for further information?

> Plus, I don't think "100% charge" is right test for "battery full". At
> least on thinkpads, there's configuration option, and it is common
> _not_ to charge batterry above 95% or so (to increase its lifetime).
>

This will only affect machines where the firmware wrongly reports the
battery state as discharging, which the commit mentioned on this
commit message fixed so we now report it as not charging. From your
comment it does not sound like thinkpads are in this category. In any
case deciding to report battery full for any percentage other than
100% is a policy decision, which is normally left out of the kernel.

>
>
> >        * was plugged in and the device thus did not start a new charge =
cycle.
> >        */
> >       if ((battery_ac_is_broken || power_supply_is_system_supplied()) &=
&
> > -         battery->rate_now =3D=3D 0)
> > +         battery->rate_now =3D=3D 0) {
> > +             if (battery->capacity_now && battery->full_charge_capacit=
y &&
> > +                 battery->capacity_now / battery->full_charge_capacity=
 =3D=3D 1)
> > +                     return POWER_SUPPLY_STATUS_FULL;
>
> Division? Really?
>

If you look further down in acpi_battery_get_property, that is how the
capacity property is calculated. Do you have a better suggestion?

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
