From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
Date: Mon, 19 Nov 2018 18:12:55 -0800
Message-ID: <CA+A7VXWwfh-jdiq60kwY65k29BXP6PNOc9=X7b6SYF9=T65UUA@mail.gmail.com>
References: <20181103065732.12134-1-jprvita@endlessm.com> <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
 <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
 <c883a2be-e772-2e18-f074-d2ad5f27f42b@redhat.com> <20181111122243.GB28794@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181111122243.GB28794@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Hans de Goede <hdegoede@redhat.com>, Daniel Drake <drake@endlessm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

On Sun, Nov 11, 2018 at 4:22 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Sun 2018-11-11 12:57:12, Hans de Goede wrote:
> > Hi,
> >
> > On 11/7/18 5:53 AM, Daniel Drake wrote:
> > >On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
> > >>Plus, I don't think "100% charge" is right test for "battery full". A=
t
> > >>least on thinkpads, there's configuration option, and it is common
> > >>_not_ to charge batterry above 95% or so (to increase its lifetime).
> > >
> > >Hans also touched on this area in his response:
> > >
> > >>As for this kernel-side fix I do not believe that fixing thus in
> > >>the kernel is the right thing to do. We try to stay away from
> > >>heuristics using full_charge_capacity in the kernel since that
> > >>is not really reliable / deterministic.
> > >
> > >I'm not fully convinced by this argument though.
> > >
> > >The ACPI spec is not very clear on what conditions you should apply to
> > >decide when the battery is full. Instead, ACPI seems to provide a
> > >pretty decent amount of data, and the decision about whether to
> > >interpret that as "battery full" is left for consumers.
> >
> > Right, but in this case the "discharging" status bit is explicitly
> > set, to me it feels wrong to report "full", when the firmware
> > is reporting "discharging" IMHO, at best we are "not charging"
> > (on AC, below the threshold where a new charge cycle starts) and
> > that is what we are currently reporting.
> >
> > Anu heurstics to decide that "not charging" is close enough to full
> > to report it as full to the user belongs in userspace IMHO.
> >
> > Anyways this ultimately is Rafael's call. If Rafael is ok with this
> > patch then I would like to see Pavel's comment addressed and otherwise
> > it is fine with me.
> >

If we can get to an agreement on this I'll send a v2 without division.

> > Note that we will still often get the case where a laptop is charged,
> > reports full, is unplugged for 5 minutes and then replugged and then
> > reports a capacity of 97% combined with "not charging", so we will
> > still need to fix userspace to handle this.
>

Yes, I agree that should be addressed in userspace, as it is pretty
much a policy decision.

> For the record, I don't think I'm okay with this.
>
> There's nothing special about 100% charge.
>

I don't agree there is nothing special about 100% charge. There is a
separate state to represent battery full for a reason, which is the
user wanting to know when their battery is 100% charged and not being
discharged.

> This changes userland ABI and I don't think it has good enough reasons
to do that.
>

This only changes which state will be reported when the battery is
100% charged and not discharging, it does not introduce / remove any
values. I don't think that is considered ABI change, and on other
hardware like the Dell Latitude 5480,
/sys/class/power_supply/<supply_name>/status already reports "Full"
under these conditions. I still believe it is a bug that makes the ABI
inconsistent across different hardware.

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
