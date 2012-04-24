From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Tue, 24 Apr 2012 21:15:37 +0800
Message-ID: <CAF1ivSbOhUbE6wreRQ5E3jV5N_haHn1y9q48CU_OZFeCRTed+A@mail.gmail.com>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
	<201204231343.03382.rjw@sisk.pl>
	<20120423151327.GA4019@fedora>
	<201204232150.57812.rjw@sisk.pl>
	<20120424020708.GA10397@localhost.amd.com>
	<1335234576.15942.19.camel@minggr>
	<20120424031011.GA27099@ladygaga>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120424031011.GA27099@ladygaga>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 24, 2012 at 11:10 AM, Aaron Lu <aaron.lu@amd.com> wrote:
> On Tue, Apr 24, 2012 at 10:29:36AM +0800, Lin Ming wrote:
>> On Tue, 2012-04-24 at 10:07 +0800, Aaron Lu wrote:
>> > On Mon, Apr 23, 2012 at 09:50:57PM +0200, Rafael J. Wysocki wrote:
>> > > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> > > > index 3263b68..187433f 100644
>> > > > --- a/drivers/acpi/bus.c
>> > > > +++ b/drivers/acpi/bus.c
>> > > > @@ -273,6 +273,9 @@ static int __acpi_bus_set_power(struct acp=
i_device *device, int state)
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > > > =A0 =A0 =A0 =A0 } else {
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (device->power.states[state=
].flags.explicit_set) {
>> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* evaluate _PS3=
 instead of _PS4 when entering D3Cold */
>> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (state =3D=3D=
 ACPI_STATE_D3)
>> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
object_name[3] -=3D 1;
>> > >
>> > > Can you just put '3' here directly? =A0That'll be much cleaner t=
han the
>> > > subtraction (that could have been -- as well).
>> > >
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acp=
i_evaluate_object(device->handle,
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 object_name, NULL, NULL);
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_FAILU=
RE(status)) {
>> > > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> > > > index 7417267..de2ae10 100644
>> > > > --- a/drivers/acpi/scan.c
>> > > > +++ b/drivers/acpi/scan.c
>> > > > @@ -887,8 +887,12 @@ static int acpi_bus_get_power_flags(struc=
t acpi_device *device)
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Evaluate "_PSx" to see if w=
e can do explicit sets */
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 object_name[2] =3D 'S';
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_get_handle(dev=
ice->handle, object_name, &handle);
>> > > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_SUCCESS(status))
>> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_SUCCESS(status)) {
>> > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ps->flags.expl=
icit_set =3D 1;
>> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Also set D3Co=
ld's explicit flag when _PS3 exists */
>> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D ACP=
I_STATE_D3_HOT)
>> > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
(ps+1)->flags.explicit_set =3D 1;
>> > >
>> > > Please don't use pointer arithmetics here. =A0I know it _happens=
_ to work,
>> > > but I don't think it's appropriate in this situation at all.
>> > >
>> >
>> > Thanks for the suggestions.
>> >
>> > What about this?
>> >
>> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> > index 3263b68..3a7860f 100644
>> > --- a/drivers/acpi/bus.c
>> > +++ b/drivers/acpi/bus.c
>> > @@ -273,6 +273,9 @@ static int __acpi_bus_set_power(struct acpi_de=
vice *device, int state)
>> > =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 } else {
>> > =A0 =A0 =A0 =A0 =A0 =A0 if (device->power.states[state].flags.expl=
icit_set) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Evaluate _PS3 when enteri=
ng D3cold */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (state =3D=3D ACPI_STATE_=
D3)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 object_name[=
3] =3D '3';
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_evaluate_o=
bject(device->handle,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 object_name, NULL, NULL);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) =
{
>> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> > index 7417267..734d946 100644
>> > --- a/drivers/acpi/scan.c
>> > +++ b/drivers/acpi/scan.c
>> > @@ -908,6 +908,10 @@ static int acpi_bus_get_power_flags(struct ac=
pi_device *device)
>> > =A0 =A0 device->power.states[ACPI_STATE_D3].flags.valid =3D 1;
>> > =A0 =A0 device->power.states[ACPI_STATE_D3].power =3D 0;
>> >
>> > + =A0 /* Also set D3cold's explicit flag when _PS3 exists */
>> > + =A0 if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit_s=
et)
>> > + =A0 =A0 =A0 =A0 =A0 device->power.states[ACPI_STATE_D3].flags.ex=
plicit_set =3D 1;
>>
>> We should use ACPI_STATE_D3_COLD instead of ACPI_STATE_D3 to make th=
ing
>> clear.
>>
> Thanks for your suggestion.
>
> Well, considering all those ACPI_STATE_D3 used in tree, I don't think=
 I
> should use ACPI_STATE_D3_COLD here, especially the two lines above ar=
e
> still using ACPI_STATE_D3.
>
> But if that is desired, we should probably change all the existing
> ACPI_STATE_D3 macros to ACPI_STATE_D3_COLD to make things clear.
>
> Or we all use ACPI_STATE_D3, since it is defined as 4 and means D3 co=
ld,
> and people will learn this, won't they?
>
> What do you think?

OK.

But we may do more cleanup later.

>
> Thanks,
> Aaron
