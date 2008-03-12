From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/4] ACPI: video: prevent ACPI video actions upon
	display switch notifications
Date: Wed, 12 Mar 2008 02:21:28 +0100
Message-ID: <1205284888.8194.72.camel@linux-2bdv.site>
References: <1201243677.4663.18.camel@acpi-sony.sh.intel.com>
	 <1205281262.8194.58.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:40720 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbYCLBVP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 21:21:15 -0400
In-Reply-To: <1205281262.8194.58.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-gfx@linux.intel.com


On Wed, 2008-03-12 at 01:21 +0100, Thomas Renninger wrote:
> On Fri, 2008-01-25 at 14:47 +0800, Zhang Rui wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> >=20
> > Display switching via ACPI control methods are known to work on non=
e
> > platform AFAIK.
> > And graphics people want to control the display switching all by th=
emselves.
> > Prevent ACPI from handling display switch hotkey events in this pat=
ch.
>=20
> I expect this one has to be reverted.
> I can double check tomorrow, but I am pretty sure I have a Compaq and
> also saw more and I expect there are a lot more that work pretty fine
> with Display Output Switching (_DOS) set to be handled by BIOS and no=
t
> graphics driver.
>=20
> As said, I can double check, but this would be a regression.
>=20
> IMO the logic should be:
>   - Let the BIOS handle the switching (also works without X)
>   - If a graphics driver gets active which can do the switching, it c=
an
>     take over control by:
>     echo 0 >/proc/acpi/video/*/DOS
>=20

I mixed this up with the default value for _DOS:
git commit a21101c46ca5b4320e31408853cdcbf7cb1ce4ed

Again, =EF=BB=BFIMO the logic should be:
 - Let the BIOS handle the switching (also works without X)
 - If a graphics driver gets active which can do the switching, it can
   take over control by:
   echo 0 >/proc/acpi/video/*/DOS

Also the bug which above commit claims to fix has an interesting add-on
comment (after the bug got closed):
----------------
My HP 6710B also crashes when DOS=3D0, DOS=3D1,2 or 3 works just fine t=
hough. This
has an GM965 intel chipset. What does the ACPI spec say about values ot=
her then
0 or 1 ?

It seems that the change that was done from 1 to 0 causes some quit bad
regressions on some laptops, while fixing others. Otoh all reporters sa=
y that
DOS=3D2 works..
=EF=BB=BF----------------

      Thomas
>=20
>    Thomas
>=20
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/video.c |   63 --------------------------------------=
-------------
> >  1 file changed, 63 deletions(-)
> >=20
> > Index: linux-2.6/drivers/acpi/video.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/acpi/video.c
> > +++ linux-2.6/drivers/acpi/video.c
> > @@ -276,7 +276,6 @@ static void acpi_video_device_rebind(str
> >  static void acpi_video_device_bind(struct acpi_video_bus *video,
> >  				   struct acpi_video_device *device);
> >  static int acpi_video_device_enumerate(struct acpi_video_bus *vide=
o);
> > -static int acpi_video_switch_output(struct acpi_video_bus *video, =
int event);
> >  static int acpi_video_device_lcd_set_level(struct acpi_video_devic=
e *device,
> >  			int level);
> >  static int acpi_video_device_lcd_get_level_current(
> > @@ -1583,64 +1582,6 @@ static int acpi_video_device_enumerate(s
> >  	return status;
> >  }
> > =20
> > -/*
> > - *  Arg:
> > - *  	video	: video bus device=20
> > - *  	event	: notify event
> > - *
> > - *  Return:
> > - *  	< 0	: error
> > - * =20
> > - *	1. Find out the current active output device.
> > - *	2. Identify the next output device to switch to.
> > - *	3. call _DSS to do actual switch.
> > - */
> > -
> > -static int acpi_video_switch_output(struct acpi_video_bus *video, =
int event)
> > -{
> > -	struct list_head *node;
> > -	struct acpi_video_device *dev =3D NULL;
> > -	struct acpi_video_device *dev_next =3D NULL;
> > -	struct acpi_video_device *dev_prev =3D NULL;
> > -	unsigned long state;
> > -	int status =3D 0;
> > -
> > -	mutex_lock(&video->device_list_lock);
> > -
> > -	list_for_each(node, &video->video_device_list) {
> > -		dev =3D container_of(node, struct acpi_video_device, entry);
> > -		status =3D acpi_video_device_get_state(dev, &state);
> > -		if (state & 0x2) {
> > -			dev_next =3D container_of(node->next,
> > -					struct acpi_video_device, entry);
> > -			dev_prev =3D container_of(node->prev,
> > -					struct acpi_video_device, entry);
> > -			goto out;
> > -		}
> > -	}
> > -
> > -	dev_next =3D container_of(node->next, struct acpi_video_device, e=
ntry);
> > -	dev_prev =3D container_of(node->prev, struct acpi_video_device, e=
ntry);
> > -
> > - out:
> > -	mutex_unlock(&video->device_list_lock);
> > -
> > -	switch (event) {
> > -	case ACPI_VIDEO_NOTIFY_CYCLE:
> > -	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:
> > -		acpi_video_device_set_state(dev, 0);
> > -		acpi_video_device_set_state(dev_next, 0x80000001);
> > -		break;
> > -	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:
> > -		acpi_video_device_set_state(dev, 0);
> > -		acpi_video_device_set_state(dev_prev, 0x80000001);
> > -	default:
> > -		break;
> > -	}
> > -
> > -	return status;
> > -}
> > -
> >  static int
> >  acpi_video_get_next_level(struct acpi_video_device *device,
> >  			  u32 level_current, u32 event)
> > @@ -1800,23 +1741,19 @@ static void acpi_video_bus_notify(acpi_h
> >  					 * connector. */
> >  		acpi_video_device_enumerate(video);
> >  		acpi_video_device_rebind(video);
> > -		acpi_video_switch_output(video, event);
> >  		acpi_bus_generate_proc_event(device, event, 0);
> >  		keycode =3D KEY_SWITCHVIDEOMODE;
> >  		break;
> > =20
> >  	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pres=
sed. */
> > -		acpi_video_switch_output(video, event);
> >  		acpi_bus_generate_proc_event(device, event, 0);
> >  		keycode =3D KEY_SWITCHVIDEOMODE;
> >  		break;
> >  	case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:	/* Next Display output hotkey=
 pressed. */
> > -		acpi_video_switch_output(video, event);
> >  		acpi_bus_generate_proc_event(device, event, 0);
> >  		keycode =3D KEY_VIDEO_NEXT;
> >  		break;
> >  	case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:	/* previous Display output ho=
tkey pressed. */
> > -		acpi_video_switch_output(video, event);
> >  		acpi_bus_generate_proc_event(device, event, 0);
> >  		keycode =3D KEY_VIDEO_PREV;
> >  		break;
> >=20
> >=20
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
