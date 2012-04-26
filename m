From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Thu, 26 Apr 2012 16:55:16 +0800
Message-ID: <CAC=cRTPqSPLHvT+BXH7K3ff0u=pFCVAG6rLNSjntpj+ghgdM+Q@mail.gmail.com>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
	<CAF1ivSbOhUbE6wreRQ5E3jV5N_haHn1y9q48CU_OZFeCRTed+A@mail.gmail.com>
	<20120424142457.GA5292@fedora>
	<201204242315.00419.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201204242315.00419.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@amd.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 25, 2012 at 5:15 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, April 24, 2012, Aaron Lu wrote:
>> On Tue, Apr 24, 2012 at 09:15:37PM +0800, Lin Ming wrote:
>> > >> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> > >> > index 7417267..734d946 100644
>> > >> > --- a/drivers/acpi/scan.c
>> > >> > +++ b/drivers/acpi/scan.c
>> > >> > @@ -908,6 +908,10 @@ static int acpi_bus_get_power_flags(stru=
ct acpi_device *device)
>> > >> > =C2=A0 =C2=A0 device->power.states[ACPI_STATE_D3].flags.valid=
 =3D 1;
>> > >> > =C2=A0 =C2=A0 device->power.states[ACPI_STATE_D3].power =3D 0=
;
>> > >> >
>> > >> > + =C2=A0 /* Also set D3cold's explicit flag when _PS3 exists =
*/
>> > >> > + =C2=A0 if (device->power.states[ACPI_STATE_D3_HOT].flags.ex=
plicit_set)
>> > >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device->power.states[ACP=
I_STATE_D3].flags.explicit_set =3D 1;
>> > >>
>> > >> We should use ACPI_STATE_D3_COLD instead of ACPI_STATE_D3 to ma=
ke thing
>> > >> clear.
>> > >>
>> > > Thanks for your suggestion.
>> > >
>> > > Well, considering all those ACPI_STATE_D3 used in tree, I don't =
think I
>> > > should use ACPI_STATE_D3_COLD here, especially the two lines abo=
ve are
>> > > still using ACPI_STATE_D3.
>> > >
>> > > But if that is desired, we should probably change all the existi=
ng
>> > > ACPI_STATE_D3 macros to ACPI_STATE_D3_COLD to make things clear.
>> > >
>> > > Or we all use ACPI_STATE_D3, since it is defined as 4 and means =
D3 cold,
>> > > and people will learn this, won't they?
>> > >
>> > > What do you think?
>> >
>> > OK.
>> >
>> > But we may do more cleanup later.
>> >
>>
>> Sure :-)
>> I think the first thing to do is to agree on which macro should be u=
sed,
>> ACPI_STATE_D3 or ACPI_STATE_D3_COLD. And then replace the other one
>> altogether.
>
> I'd prefer to use ACPI_STATE_D3 wherever it makes sense, because that=
's
> also well defined in older versions of ACPI (think pre-ACPI-4.0 BIOSe=
s).

Because the relationship between ACPI_STATE_D3 and ACPI_STATE_D3_COLD
is confusing, I suggest to add some comments whenever will refer to D3
or D3_COLD.

Best Regards,
Huang Ying
