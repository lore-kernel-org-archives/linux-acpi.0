From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Wed, 7 Nov 2018 12:53:03 +0800
Message-ID: <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
References: <20181103065732.12134-1-jprvita@endlessm.com> <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, sebastian.reichel@collabora.co.uk, Linux Kernel <linux-kernel@vger.kernel.org>, linux@endlessm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
> Plus, I don't think "100% charge" is right test for "battery full". At
> least on thinkpads, there's configuration option, and it is common
> _not_ to charge batterry above 95% or so (to increase its lifetime).

Hans also touched on this area in his response:

> As for this kernel-side fix I do not believe that fixing thus in
> the kernel is the right thing to do. We try to stay away from
> heuristics using full_charge_capacity in the kernel since that
> is not really reliable / deterministic.

I'm not fully convinced by this argument though.

The ACPI spec is not very clear on what conditions you should apply to
decide when the battery is full. Instead, ACPI seems to provide a
pretty decent amount of data, and the decision about whether to
interpret that as "battery full" is left for consumers.

The best that the ACPI spec offers here is the _BIF/_BIX "Last Full
Charge Capacity" field (known as full_charge_capacity in this driver),
and it does appear to consider the "only charge to 95%" consideration,
although it is only documented as a prediction. There is also a sample
calculation (section 3.9.3) of how to calculate the Remaining Battery
Percentage which uses "Last Full Charge Capacity" too.

Without a crystal clear definition of battery full, it seems up to the
consumers of the data to decide when the battery is full via some form
of heuristic. And this is exactly what acpi-battery already does in
acpi_battery_is_charged() - and the main aspect is looking at
full_charge_capacity. The result of this is then sent to userspace.

So it does not seem fair to say that "you can't use basic heuristics
around full_charge_capacity" because the kernel already does (and this
is what the ACPI spec encourages), although JP's patch could be
improved to more clearly and more completely follow the logic in
acpi_battery_is_charged().

The question of whether we would want to interpret the numbers in this
way when DISCHARGING is set is a good one though. The ACPI spec
doesn't shine much light on this, but the calculations related to
battery percentage and battery life in section 3.9.3 at least do not
seem to consider charging/discharging status.

Thanks
Daniel
