From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 1/2] acpi: video: add function to support unregister
 backlight
Date: Mon, 29 Apr 2013 18:06:06 +0800
Message-ID: <1367229966.22858.52.camel@linux-s257.site>
References: <1366634355-26482-1-git-send-email-jlee@suse.com>
	 <1366634355-26482-2-git-send-email-jlee@suse.com>
	 <517A0FA1.3040406@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <517A0FA1.3040406@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: mjg@redhat.com, rjw@sisk.pl, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dtor@mail.ru>, Corentin Chary <corentincj@iksaif.net>, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E4=BA=94=EF=BC=8C2013-04-26 =E6=96=BC 13:24 +0800=EF=BC=8CAa=
ron Lu =E6=8F=90=E5=88=B0=EF=BC=9A
> On 04/22/2013 08:39 PM, Chun-Yi Lee wrote:
> > From: "Lee, Chun-Yi" <jlee@suse.com>
> >
> > There have situation we unregister whole acpi/video driver by downs=
tream driver
> > just want to remove backlight control interface of acpi/video. It c=
aues we lost
> > other functions of acpi/video, e.g. transfer acpi event to input ev=
ent.
> >
> > So, this patch add a new function, find_video_unregister_backlight,=
 it provide
> > the interface let downstream driver can tell acpi/video to unregist=
er backlight
> > interface of all acpi video devices. Then we can keep functions of =
acpi/video
> > but only remove backlight support.
> >
> > Reference: bko#35622
> >          https://bugzilla.kernel.org/show_bug.cgi?id=3D35622
> >
> > Tested-by: Andrzej Krentosz <endrjux@gmail.com>
> > Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>
> > Cc: Matthew Garrett <mjg@redhat.com>
> > Cc: Dmitry Torokhov <dtor@mail.ru>
> > Cc: Corentin Chary <corentincj@iksaif.net>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Aaron Lu <aaron.lu@intel.com>
> > Cc: Thomas Renninger <trenn@suse.de>
> > Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
> > ---
> >   drivers/acpi/video.c | 46 +++++++++++++++++++++++++++++++++++++++=
+++++++
> >   include/acpi/video.h |  2 ++
> >   2 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> > index 313f959..acd2e7a 100644
> > --- a/drivers/acpi/video.c
> > +++ b/drivers/acpi/video.c
> > @@ -1793,6 +1793,52 @@ static int __init intel_opregion_present(voi=
d)
> >   	return opregion;
> >   }
> >
> > +static acpi_status
> > +find_video_unregister_backlight(acpi_handle handle, u32 lvl, void =
*context,
> > +				void **rv)
> > +{
> > +	struct acpi_device *acpi_dev;
> > +	struct acpi_video_bus *video =3D NULL;
> > +	struct acpi_video_device *dev, *next;
> > +
> > +	if (acpi_bus_get_device(handle, &acpi_dev))
> > +		return AE_OK;
> > +
> > +	if (!acpi_match_device_ids(acpi_dev, video_device_ids)) {
> > +		video =3D acpi_driver_data(acpi_dev);
> > +		acpi_video_bus_stop_devices(video);
> > +		mutex_lock(&video->device_list_lock);
> > +		list_for_each_entry_safe(dev, next, &video->video_device_list,
> > +					entry) {
> > +			if (dev->backlight) {
> > +				backlight_device_unregister(dev->backlight);
> > +				dev->backlight =3D NULL;
> > +				kfree(dev->brightness->levels);
> > +				kfree(dev->brightness);
> > +			}
>=20
> The cooling_dev should also be unregistered I think.
>=20
> Thanks,
> Aaron
>=20

Yes, you are right!

Unregistering  backlight interface of video devices means the backlight
control functions broken, so it can not used for throttling.

I will unregister cooling_dev in v2 patch.


Thanks a lot!
Joey Lee
