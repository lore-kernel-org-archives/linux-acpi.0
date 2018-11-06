From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Tue, 6 Nov 2018 12:14:08 -0800
Message-ID: <CA+A7VXUBCp3i18bz+LQ+gVpf_UdZALU=UpHXcCQ8V-eTSwOkJQ@mail.gmail.com>
References: <20181103065732.12134-1-jprvita@endlessm.com> <566af8d6-638e-8c7b-71b4-a7a8d6e71cdb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566af8d6-638e-8c7b-71b4-a7a8d6e71cdb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

Hello Hans, thanks for your quick response,

On Sat, Nov 3, 2018 at 4:28 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 03-11-18 07:57, Jo=C3=A3o Paulo Rechi Vita wrote:
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
> acpi_battery_handle_discharging() only gets called if the ACPI_BATTERY_ST=
ATE_DISCHARGING
> bit is set by the firmware in that case if we are not actually dischargin=
g
> returning POWER_SUPPLY_STATUS_NOT_CHARGING is the only correct thing to d=
o,
> we should never return POWER_SUPPLY_STATUS_FULL when the
> ACPI_BATTERY_STATE_DISCHARGING bit is set.
>

I understand the reason behind your original patch, but can you
elaborate on why would it be wrong to return POWER_SUPPLY_STATUS_FULL
if the battery is full and we know it is not actually discharging?
IIUC that is the state returned on hw / firmware that behaves
correctly when there is AC power and the battery has 100% of charge.

> I was about to point you to the upower bug for upower not
> handling POWER_SUPPLY_STATUS_NOT_CHARGING as well as it
> could atm, but I see you've already found that and are working
> on fixing that. That is great, thank you.
>

Yes, I'm trying to fix this problem, but it touches different points
across the stack and there are different possible approaches for how
to present the "Not charging" state to the user. This patch is not
necessarily part of, although closely related to, the bigger problem
of better handling "Not charging". It actually addresses the problem
that the kernel returns "Not charging" when AC is present and the
battery is fully charged, which seems wrong to me, despite of "Not
charging" not being strictly defined anywhere (at least that I know
of).

> As for this kernel-side fix I do not believe that fixing thus in
> the kernel is the right thing to do. We try to stay away from
> heuristics using full_charge_capacity in the kernel since that
> is not really reliable / deterministic.
>

At first I thought that returning POWER_SUPPLY_STATUS_FULL when the
battery is full and AC is present was deterministic enough to have it
in the kernel. But I don't have any prior experience working with this
kind of hardware, so I may very well be wrong on this assumption. It
would be great to get some extra clarification though.

Thanks,
--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
