From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 19/32] dell-laptop: Port to new backlight interface
 selection API
Date: Thu, 11 Jun 2015 15:06:31 +0200
Message-ID: <20150611130631.GG19820@pali>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com>
 <1433941292-21530-20-git-send-email-hdegoede@redhat.com>
 <20150611114709.GD19820@pali>
 <55797F24.8060500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55797F24.8060500@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 11 June 2015 14:29:24 Hans de Goede wrote:
> Hi,
>=20
> On 11-06-15 13:47, Pali Roh=C3=A1r wrote:
> >On Wednesday 10 June 2015 15:01:19 Hans de Goede wrote:
> >>Port the backlight selection logic to the new backlight interface
> >>selection API.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  drivers/platform/x86/dell-laptop.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >>diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/=
x86/dell-laptop.c
> >>index d688d80..db2e031 100644
> >>--- a/drivers/platform/x86/dell-laptop.c
> >>+++ b/drivers/platform/x86/dell-laptop.c
> >>@@ -31,6 +31,7 @@
> >>  #include <linux/slab.h>
> >>  #include <linux/debugfs.h>
> >>  #include <linux/seq_file.h>
> >>+#include <acpi/video.h>
> >>  #include "../../firmware/dcdbas.h"
> >>
> >>  #define BRIGHTNESS_TOKEN 0x7d
> >>@@ -1921,10 +1922,7 @@ static int __init dell_init(void)
> >>  				    &dell_debugfs_fops);
> >>
> >>  #ifdef CONFIG_ACPI
> >>-	/* In the event of an ACPI backlight being available, don't
> >>-	 * register the platform controller.
> >>-	 */
> >>-	if (acpi_video_backlight_support())
> >>+	if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
> >>  		return 0;
> >>  #endif
> >>
> >
> >Now I'm thinking... Is this correct condition? And do we need it? Th=
is
> >Dell backlight interface works even if ACPI or intel i915 driver
> >controls backlight. Why we should prevent dell-laptop.ko to register
> >Dell backlight interface if ACPI video already register one? And why=
 not
> >prevent when intel i915 driver register another?
>=20
> 3 things:
>=20
> 1) This is mostly a cleanup series, it does not make any behavioral
> changes (other then renaming the kernelcmdline option and we've
> already discussed fixing that).
>=20
> 2) All 3 drivers ultimately bit-bang the same hardware, we really sho=
uld
> have only one driver banging the hardware, so
> 	if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
> 		return 0;
>=20
> Definitely is the right thing todo here.
>=20
> 3) You're right that the intel_backlight still registering even if
> acpi_video_get_backlight_type() !=3D acpi_backlight_native is weird, =
but
> that is how it was before this series, and userspace prefers firmware
> type backlight sysfs entries over platform /raw ones so it will
> automatically pick the right one.  We should consider not registering
> the backlight sysfs class interface from the intel code when
> acpi_video_get_backlight_type() !=3D acpi_backlight_native but that i=
s
> something for later...
>=20
> Regards,
>=20
> Hans

Ok. This patch series is just refactor/cleanup which does not change
functional behavior. I'm ok with this dell-laptop change, so you can ad=
d
my Acked-By.

Once you will create new patches for backlight (maybe for intel i915),
please CC me, so I can discuss about them too.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
