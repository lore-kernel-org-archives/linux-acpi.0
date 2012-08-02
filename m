From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH/RFC] drm/radeon: ACPI: veto the keypress on ATIF events
Date: Thu, 02 Aug 2012 08:45:30 +0800
Message-ID: <1343868330.1682.502.camel@rui.sh.intel.com>
References: <20120728145626.GA6304@growl>
	 <CADnq5_OjWoLS=GO_qYEBeTPvXrKJeJUjUCzOZS5w3erjHeFDqg@mail.gmail.com>
	 <20120729130644.GA12378@growl>
	 <CADnq5_OdKXsiVnFbkBNB2ue4df6tGaZ7bVMP+TvetFcy0faKog@mail.gmail.com>
	 <20120730202449.GA5600@growl>
	 <CADnq5_NP9Rw8DhmS+Q5G1PaUqcHQtVA6KoCGH5MME6DEd-Lw7Q@mail.gmail.com>
	 <CAKPcRGpL6JBx5MnWk6fFVOYCPQGeeDC-ytOwA+J+gEEZS+4SuA@mail.gmail.com>
	 <CADnq5_NN8OcmyKDemO=Mv0as-02sYEHxxbn2G4XtSmpzEsnR0w@mail.gmail.com>
	 <20120731200520.GA5425@growl>
	 <CADnq5_Meh0nW90PZ=kAJdK=WjZKTdr7+5vN=vza+PzyJnEWKAA@mail.gmail.com>
	 <20120801134900.GA7909@growl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50387 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303Ab2HBAoR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Aug 2012 20:44:17 -0400
In-Reply-To: <20120801134900.GA7909@growl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, joeyli <jlee@suse.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On =E4=B8=89, 2012-08-01 at 15:49 +0200, Luca Tettamanti wrote:
> AMD ACPI interface may overload the standard event
> ACPI_VIDEO_NOTIFY_PROBE (0x81) to signal AMD-specific events. In such
> cases we don't want to send the keypress (KEY_SWITCHVIDEOMODE) to the
> userspace because the user did not press the mode switch key (the
> spurious keypress confuses the DE which usually changes the
> display configuration and messes up a dual-screen setup).
> This patch gives the radeon driver the chance to examine the event an=
d
> block the keypress if the event is an "AMD event".
>=20
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> ---
> Any comment from ACPI front?
>=20
it looks good to me.
But I'm wondering if we can use the following code for ACPI part, which
looks cleaner.
I know this may change the behavior of other events, but in theory, we
should not send any input event if we know something wrong in kernel.

what do you think?

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1e0a9e1..8ad1f53 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1448,8 +1448,7 @@ static void acpi_video_bus_notify(struct acpi_dev=
ice *device, u32 event)
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
 					 * most likely via hotkey. */
 		acpi_bus_generate_proc_event(device, event, 0);
-		if (!acpi_notifier_call_chain(device, event, 0))
-			keycode =3D KEY_SWITCHVIDEOMODE;
+		keycode =3D KEY_SWITCHVIDEOMODE;
 		break;
=20
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
@@ -1479,8 +1478,8 @@ static void acpi_video_bus_notify(struct acpi_dev=
ice *device, u32 event)
 		break;
 	}
=20
-	if (event !=3D ACPI_VIDEO_NOTIFY_SWITCH)
-		acpi_notifier_call_chain(device, event, 0);
+	if (acpi_notifier_call_chain(device, event, 0))
+		keycode =3D 0;
=20
 	if (keycode) {
 		input_report_key(input, keycode, 1);


>  drivers/acpi/video.c                 |   10 ++++++++--
>  drivers/gpu/drm/radeon/radeon_acpi.c |    7 ++++++-
>  2 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 1e0a9e1..a8592c4 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -1457,7 +1457,12 @@ static void acpi_video_bus_notify(struct acpi_=
device *device, u32 event)
>  		acpi_video_device_enumerate(video);
>  		acpi_video_device_rebind(video);
>  		acpi_bus_generate_proc_event(device, event, 0);
> -		keycode =3D KEY_SWITCHVIDEOMODE;
> +		/* This event is also overloaded by AMD ACPI interface, don't
> +		 * send the key press if the event has been handled elsewhere
> +		 * (e.g. radeon DRM driver).
> +		 */
> +		if (!acpi_notifier_call_chain(device, event, 0))
> +			keycode =3D KEY_SWITCHVIDEOMODE;
>  		break;
> =20
>  	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey presse=
d. */
> @@ -1479,7 +1484,8 @@ static void acpi_video_bus_notify(struct acpi_d=
evice *device, u32 event)
>  		break;
>  	}
> =20
> -	if (event !=3D ACPI_VIDEO_NOTIFY_SWITCH)
> +	if (event !=3D ACPI_VIDEO_NOTIFY_SWITCH &&
> +			event !=3D ACPI_VIDEO_NOTIFY_PROBE)
>  		acpi_notifier_call_chain(device, event, 0);
> =20
>  	if (keycode) {
> diff --git a/drivers/gpu/drm/radeon/radeon_acpi.c b/drivers/gpu/drm/r=
adeon/radeon_acpi.c
> index 96de08d..ee0d29e 100644
> --- a/drivers/gpu/drm/radeon/radeon_acpi.c
> +++ b/drivers/gpu/drm/radeon/radeon_acpi.c
> @@ -273,7 +273,12 @@ int radeon_atif_handler(struct radeon_device *rd=
ev,
>  	}
>  	/* TODO: check other events */
> =20
> -	return NOTIFY_OK;
> +	/* We've handled the event, stop the notifier chain. The ACPI inter=
face
> +	 * overloads ACPI_VIDEO_NOTIFY_PROBE, we don't want to send that to
> +	 * userspace if the event was generated only to signal a SBIOS
> +	 * request.
> +	 */
> +	return NOTIFY_BAD;
>  }
> =20
>  /* Call all ACPI methods here */


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
