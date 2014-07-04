From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: Re: [PATCH] drm/i915/opregion: ignore firmware requests
 for backlight change
Date: Fri, 04 Jul 2014 12:06:23 +0400
Message-ID: <1404461183.19977.35.camel@X1Carbon.localdomain>
References: <53A8E400.5060709@intel.com> <87tx796yc5.fsf@intel.com>
 <53ACE2EF.8020808@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1993307471=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <53ACE2EF.8020808@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Anton Gubarkov <anton.gubarkov@gmail.com>
List-Id: linux-acpi@vger.kernel.org


--===============1993307471==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wsNpBeT4aHO9fG9S5rkT"


--=-wsNpBeT4aHO9fG9S5rkT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2014-06-27 at 11:20 +0800, Aaron Lu wrote:=20
> On 06/25/2014 07:08 PM, Jani Nikula wrote:
> > On Tue, 24 Jun 2014, Aaron Lu <aaron.lu@intel.com> wrote:
> >> Some Thinkpad laptops' firmware will initiate a backlight level change
> >> request through operation region on the events of AC plug/unplug, but
> >> since we are not using firmware's interface to do the backlight settin=
g
> >> on these affected laptops, we do not want the firmware to use some
> >> arbitrary value from its ASL variable to set the backlight level on
> >> AC plug/unplug either.
> >=20
> > I'm curious whether this happens with EFI boot, or only with legacy.
>=20
> Igor, Anton,
Hi,
> Are you using legacy boot or UEFI boot?
I'm using UEFI.=20
> Possible to test the other case?
yes, I'll test it with legacy in 10 mins.=20
>=20
> >=20
> > One comment inline, otherwise
>=20
> Will add that in next revision.
>=20
> >=20
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
>=20
> Thanks for the review!
>=20
> -Aaron
>=20
> >=20
> > for merging through the ACPI tree, as the change is more likely to
> > conflict there.
> >=20
> >> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D76491
> >> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=3D77091
> >> Reported-and-tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> >> Reported-and-tested-by: Anton Gubarkov <anton.gubarkov@gmail.com>
> >> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> >> ---
> >>  drivers/acpi/video.c                  | 3 ++-
> >>  drivers/gpu/drm/i915/intel_opregion.c | 7 +++++++
> >>  include/acpi/video.h                  | 2 ++
> >>  3 files changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> >> index fb9ffe9adc64..cf99d6d2d491 100644
> >> --- a/drivers/acpi/video.c
> >> +++ b/drivers/acpi/video.c
> >> @@ -241,13 +241,14 @@ static bool acpi_video_use_native_backlight(void=
)
> >>  		return use_native_backlight_dmi;
> >>  }
> >> =20
> >> -static bool acpi_video_verify_backlight_support(void)
> >> +bool acpi_video_verify_backlight_support(void)
> >>  {
> >>  	if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
> >>  	    backlight_device_registered(BACKLIGHT_RAW))
> >>  		return false;
> >>  	return acpi_video_backlight_support();
> >>  }
> >> +EXPORT_SYMBOL(acpi_video_verify_backlight_support);
> >> =20
> >>  /* backlight device sysfs support */
> >>  static int acpi_video_get_brightness(struct backlight_device *bd)
> >> diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i=
915/intel_opregion.c
> >> index 2e2c71fcc9ed..02943d93e88e 100644
> >> --- a/drivers/gpu/drm/i915/intel_opregion.c
> >> +++ b/drivers/gpu/drm/i915/intel_opregion.c
> >> @@ -403,6 +403,13 @@ static u32 asle_set_backlight(struct drm_device *=
dev, u32 bclp)
> >> =20
> >>  	DRM_DEBUG_DRIVER("bclp =3D 0x%08x\n", bclp);
> >> =20
> >> +	/*
> >> +	 * If the acpi_video interface is not supposed to be used, don't
> >> +	 * bother processing backlight level change requests from firmware.
> >> +	 */
> >> +	if (!acpi_video_verify_backlight_support())
> >> +		return 0;
> >=20
> > I'd appreciate a DRM_DEBUG_KMS here about what happened. We're bound to
> > wonder about that staring at some dmesg later on!
> >=20
> >> +
> >>  	if (!(bclp & ASLE_BCLP_VALID))
> >>  		return ASLC_BACKLIGHT_FAILED;
> >> =20
> >> diff --git a/include/acpi/video.h b/include/acpi/video.h
> >> index ea4c7bbded4d..92f8c4bffefb 100644
> >> --- a/include/acpi/video.h
> >> +++ b/include/acpi/video.h
> >> @@ -22,6 +22,7 @@ extern void acpi_video_unregister(void);
> >>  extern void acpi_video_unregister_backlight(void);
> >>  extern int acpi_video_get_edid(struct acpi_device *device, int type,
> >>  			       int device_id, void **edid);
> >> +extern bool acpi_video_verify_backlight_support(void);
> >>  #else
> >>  static inline int acpi_video_register(void) { return 0; }
> >>  static inline void acpi_video_unregister(void) { return; }
> >> @@ -31,6 +32,7 @@ static inline int acpi_video_get_edid(struct acpi_de=
vice *device, int type,
> >>  {
> >>  	return -ENODEV;
> >>  }
> >> +static bool acpi_video_verify_backlight_support() { return false; }
> >>  #endif
> >> =20
> >>  #endif
> >> --=20
> >> 1.9.3
> >>
> >=20
>=20


--=20
-Igor Gnatenko

--=-wsNpBeT4aHO9fG9S5rkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTtmB/AAoJEAmtnLFRuIbqcHwIAMYlbMJ80EoP6n1v640LO95B
Cuh6w5JTdOEGBB/zgYfZK6E5UXUlUylAsIp51tsPTUjvzevVdgg0lsecWQdvipy2
Y8tEVYxLNEzZJSOUwM7ZOeV5iPYOMKmyUnZi83bim5dw34FP36mtOafwhw+oJ862
18FgQIh/k0HbGCZVVcT00T26m0TUyEPRuRALexkv8S3+c+AVDRMXb4ocF6MBSAP5
T4HGERmFc5kPXrYHto04XwhJD76frcZ8+rSyHfYS2Ww6JX4lFA7JWgiQzdUuJR/w
5JxKOLE1hUrjMZBmyxmmxhI5Y0zTOcMkGWaj5yY0/0a8IBO3mKCtOdMhfRoKHig=
=bm/r
-----END PGP SIGNATURE-----

--=-wsNpBeT4aHO9fG9S5rkT--


--===============1993307471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1993307471==--
