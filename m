From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] [PATCH 1/3] ACPI: save/restore ACPI NVS memory during hibernation
Date: Wed, 25 Jun 2008 17:30:48 +0200
Message-ID: <200806251730.49201.rjw@sisk.pl>
References: <1214293383.3001.108.camel@rzhang-dt.sh.intel.com> <200806241218.25691.rjw@sisk.pl> <1214362501.3001.134.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53180 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbYFYP3V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jun 2008 11:29:21 -0400
In-Reply-To: <1214362501.3001.134.camel@rzhang-dt.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-power-mgmt <linux-power-mgmt@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Wednesday, 25 of June 2008, Zhang Rui wrote:
>=20
> On Tue, 2008-06-24 at 18:18 +0800, Rafael J. Wysocki wrote:
> > On Tuesday, 24 of June 2008, Zhang Rui wrote:
> > > According to the ACPI spec, ACPI NVS memory region is required to=
 be
> > > saved/restored by OS during hibernation.
> > >
> > > Section 15.3.2 ACPI Spec 3.0b,
> > > "OSPM will call the _PTS control method some time before entering=
 a
> > sleeping state,
> > > to allow the platform=E2=80=99s AML code to update this memory im=
age before
> > entering the
> > > sleeping state. After the system awakes from an S4 state, OSPM wi=
ll
> > restore this memory
> > > area and call the _WAK control method to enable the BIOS to recla=
im
> > its memory image."
> > >
> > > Add the mechanism to save/restore ACPI NVS memory during
> > hibernation.
> > >
> > > Note: now Linux save ACPI NVS memory in
> > acpi_hibernation_pre_snapshot, and restore it in
> > >       acpi_hibernation_leave. Both of these functions will be
> > invoked only once during
> > >       the hibernate and resume.
> > > Note: in Section 14.3 ACPI spec 3.0b, I only get
> > >       "EfiACPIMemoryNVS: The OS and loader must preserve this mem=
ory
> > range in
> > >       the working and ACPI S1=E2=80=93S3 states."
> > >       whether we should save/restore this piece of memory is not
> > cleared.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >=20
> > Well, I know what the specification says, but we tried that in the
> > past and it
> > caused regressions.
> Yes, Shaohua generated the prototype patches a couple of years ago.
> But this is slightly different from the original one, e.g. not touchi=
ng
> ACPI DATA memory, saving ACPI NVS memory after _PTS and restore it
> before _WAK strictly, etc.
> We generate this patch set and hope it be helpful for some hibernate
> specific issues.
>=20
> > > +
> > > +static int
> > > +acpi_hibernation_notifier_cb(struct notifier_block *nb,
> > > +                     unsigned long val, void *data)
> > > +{
> > > +     int result =3D 0;
> > > +
> > > +     switch (val) {
> > > +     case PM_HIBERNATION_PREPARE:
> > > +             result =3D acpi_hibernation_allocate_nvs_pages();
> > > +             break;
> > > +     case PM_POST_RESTORE: /* Failed */
> > > +     case PM_POST_HIBERNATION:
> > > +             acpi_hibernation_free_nvs_pages();
> > > +     }
> > > +     return result;
> > > +}
> > > +
> > > +struct notifier_block acpi_hibernation_nb =3D {
> > > +     .notifier_call =3D acpi_hibernation_notifier_cb,
> > > +};
> >=20
> > This is over the top, IMO.  Please put the appropriate call into
> > acpi_hibernation_begin() and create acpi_hibernation_end() with the
> > call to
> > acpi_hibernation_free_nvs_pages() (it must do what acpi_pm_end() do=
es
> > apart
> > from this).
> Pages for ACPI NVS must be allocated before swsusp_shrink_memory.

Saying "must" in this context is way too strong IMO. :-)

=46irst, you can allocate memory after swsusp_shrink_memory(), although=
 you
can't allocate too much memory, where how much is "too much" really dep=
ends on
the requested size of the image.  It certanly cannot be more than the I=
/O and
spare pages reserve which is 5 MB at present.  I don't think there's so=
 much
NVS memory to save in any case.

Still, if you really want to avoid the memory problem, it's better to c=
hange
the ordering between swsusp_shrink_memory() and platform_begin() in
kernel/power/disk.c:hibernation_snapshot() than to add a new notifier.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
