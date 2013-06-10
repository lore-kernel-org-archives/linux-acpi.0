From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 3/3] i915: Don't provide ACPI backlight interface if
 firmware expects Windows 8
Date: Mon, 10 Jun 2013 17:22:23 +0800
Message-ID: <1370856143.6523.114.camel@linux-s257.site>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
	 <1370818899-8595-4-git-send-email-matthew.garrett@nebula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370818899-8595-4-git-send-email-matthew.garrett@nebula.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: linux-acpi@vger.kernel.org, seth.forshee@canonical.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

=E6=96=BC =E6=97=A5=EF=BC=8C2013-06-09 =E6=96=BC 19:01 -0400=EF=BC=8CMa=
tthew Garrett =E6=8F=90=E5=88=B0=EF=BC=9A
> Windows 8 leaves backlight control up to individual graphics drivers =
rather
> than making ACPI calls itself. There's plenty of evidence to suggest =
that
> the Intel driver for Windows doesn't use the ACPI interface, includin=
g the
> fact that it's broken on a bunch of machines when the OS claims to su=
pport
> Windows 8. The simplest thing to do appears to be to disable the ACPI
> backlight interface on these systems.
>=20
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> ---
>  drivers/gpu/drm/i915/i915_dma.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i=
915_dma.c
> index 3b315ba..23b6292 100644
> --- a/drivers/gpu/drm/i915/i915_dma.c
> +++ b/drivers/gpu/drm/i915/i915_dma.c
> @@ -1661,6 +1661,9 @@ int i915_driver_load(struct drm_device *dev, un=
signed long flags)
>  		/* Must be done after probing outputs */
>  		intel_opregion_init(dev);
>  		acpi_video_register();
> +		/* Don't use ACPI backlight functions on Windows 8 platforms */
> +		if (acpi_osi_version() >=3D ACPI_OSI_WIN_8)
> +			acpi_video_backlight_unregister();
>  	}
> =20
>  	if (IS_GEN5(dev))

This patch set works to me on Acer Aspire V3 notebook for unregister th=
e
backlight interface of acpi video driver when i915 loaded. Acer Aspire
V3 has the Windows8 support in DSDT.

Tested-by: Lee, Chun-Yi <jlee@suse.com>


Thanks a lot!
Joey Lee
