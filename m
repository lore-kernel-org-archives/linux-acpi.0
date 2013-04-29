From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 2/2] acer-wmi: add Acer Aspire 5750G to video vendor
 list but keep acpi video driver
Date: Mon, 29 Apr 2013 17:21:10 +0800
Message-ID: <1367227270.22858.44.camel@linux-s257.site>
References: <1366634355-26482-1-git-send-email-jlee@suse.com>
	 <20130423040413.GA2435@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20130423040413.GA2435@core.coreip.homeip.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mjg@redhat.com, rjw@sisk.pl, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin Chary <corentincj@iksaif.net>, Aaron Lu <aaron.lu@intel.com>, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

Hi Dmitry,=20

Thanks for your review and suggestion!

=E6=96=BC =E4=B8=80=EF=BC=8C2013-04-22 =E6=96=BC 21:04 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> On Mon, Apr 22, 2013 at 08:39:14PM +0800, Chun-Yi Lee wrote:
> > From: Lee, Chun-Yi <jlee@suse.com>
> >=20
> > After Andrzej's testing, we found the acpi backlight methods broken=
 on Acer
> > Aspire 5750G but the i915 backlight control works when we set to ve=
ndor mode.
> > And, we still want to keep the acpi/video driver for transfer acpi =
event to key
> > event but not unregister whole acpi/video driver.
> >=20
> > This patch introduced a new capability flag is ACER_CAP_KEEP_VIDEO_=
KEY, it
> > indicates the machine works fine with acpi/video driver for key eve=
nt but want
> > to unregister the backlight interface of acpi/video.
> >=20
> > Reference: bko#35622
> >         https://bugzilla.kernel.org/show_bug.cgi?id=3D35622
> >=20
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
> >  drivers/platform/x86/acer-wmi.c |   20 ++++++++++++++++++++
> >  1 files changed, 20 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86=
/acer-wmi.c
> > index c9076bd..2a02409 100644
> > --- a/drivers/platform/x86/acer-wmi.c
> > +++ b/drivers/platform/x86/acer-wmi.c
> > @@ -207,6 +207,7 @@ struct hotkey_function_type_aa {
> >  #define ACER_CAP_BRIGHTNESS		(1<<3)
> >  #define ACER_CAP_THREEG			(1<<4)
> >  #define ACER_CAP_ACCEL			(1<<5)
> > +#define ACER_CAP_KEEP_VIDEO_KEY		(1<<6)
> >  #define ACER_CAP_ANY			(0xFFFFFFFF)
> > =20
> >  /*
> > @@ -539,6 +540,15 @@ static int video_set_backlight_video_vendor(co=
nst struct dmi_system_id *d)
> >  	return 0;
> >  }
> > =20
> > +static int video_set_backlight_video_vendor_keep_acpi_video(
> > +		const struct dmi_system_id *d)
> > +{
> > +	video_set_backlight_video_vendor(d);
> > +	interface->capability |=3D ACER_CAP_KEEP_VIDEO_KEY;
> > +	pr_info("Keep acpi video driver for emit keycode against backligh=
t change\n");
>=20
> Huh?
>=20
> "Keeping acpi video driver active to emit backlight brightness change
> key events"?
>=20
> Thanks.
>=20

Yes, this statement is more fluent, I will put to v2 patch.


Thanks a lot!
Joey Lee
