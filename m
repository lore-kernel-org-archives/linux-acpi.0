From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC] [PATCH 1/3] ACPI: save/restore ACPI NVS memory during
	hibernation
Date: Wed, 25 Jun 2008 10:55:00 +0800
Message-ID: <1214362501.3001.134.camel@rzhang-dt.sh.intel.com>
References: <1214293383.3001.108.camel@rzhang-dt.sh.intel.com>
	 <200806241218.25691.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10853 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYFYCyX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jun 2008 22:54:23 -0400
In-Reply-To: <200806241218.25691.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-power-mgmt <linux-power-mgmt@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>


On Tue, 2008-06-24 at 18:18 +0800, Rafael J. Wysocki wrote:
> On Tuesday, 24 of June 2008, Zhang Rui wrote:
> > According to the ACPI spec, ACPI NVS memory region is required to b=
e
> > saved/restored by OS during hibernation.
> >
> > Section 15.3.2 ACPI Spec 3.0b,
> > "OSPM will call the _PTS control method some time before entering a
> sleeping state,
> > to allow the platform=E2=80=99s AML code to update this memory imag=
e before
> entering the
> > sleeping state. After the system awakes from an S4 state, OSPM will
> restore this memory
> > area and call the _WAK control method to enable the BIOS to reclaim
> its memory image."
> >
> > Add the mechanism to save/restore ACPI NVS memory during
> hibernation.
> >
> > Note: now Linux save ACPI NVS memory in
> acpi_hibernation_pre_snapshot, and restore it in
> >       acpi_hibernation_leave. Both of these functions will be
> invoked only once during
> >       the hibernate and resume.
> > Note: in Section 14.3 ACPI spec 3.0b, I only get
> >       "EfiACPIMemoryNVS: The OS and loader must preserve this memor=
y
> range in
> >       the working and ACPI S1=E2=80=93S3 states."
> >       whether we should save/restore this piece of memory is not
> cleared.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>=20
> Well, I know what the specification says, but we tried that in the
> past and it
> caused regressions.
Yes, Shaohua generated the prototype patches a couple of years ago.
But this is slightly different from the original one, e.g. not touching
ACPI DATA memory, saving ACPI NVS memory after _PTS and restore it
before _WAK strictly, etc.
We generate this patch set and hope it be helpful for some hibernate
specific issues.

> > +
> > +static int
> > +acpi_hibernation_notifier_cb(struct notifier_block *nb,
> > +                     unsigned long val, void *data)
> > +{
> > +     int result =3D 0;
> > +
> > +     switch (val) {
> > +     case PM_HIBERNATION_PREPARE:
> > +             result =3D acpi_hibernation_allocate_nvs_pages();
> > +             break;
> > +     case PM_POST_RESTORE: /* Failed */
> > +     case PM_POST_HIBERNATION:
> > +             acpi_hibernation_free_nvs_pages();
> > +     }
> > +     return result;
> > +}
> > +
> > +struct notifier_block acpi_hibernation_nb =3D {
> > +     .notifier_call =3D acpi_hibernation_notifier_cb,
> > +};
>=20
> This is over the top, IMO.  Please put the appropriate call into
> acpi_hibernation_begin() and create acpi_hibernation_end() with the
> call to
> acpi_hibernation_free_nvs_pages() (it must do what acpi_pm_end() does
> apart
> from this).
Pages for ACPI NVS must be allocated before swsusp_shrink_memory.
And none platform hibernation ops can be used in this case.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
