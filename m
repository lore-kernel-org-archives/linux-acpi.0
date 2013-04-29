From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 1/2] acpi: video: add function to support unregister
 backlight
Date: Mon, 29 Apr 2013 17:19:27 +0800
Message-ID: <1367227167.22858.42.camel@linux-s257.site>
References: <1366634355-26482-1-git-send-email-jlee@suse.com>
	 <1366634355-26482-2-git-send-email-jlee@suse.com>
	 <20130423041245.GB2435@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41307 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab3D2JU6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2013 05:20:58 -0400
In-Reply-To: <20130423041245.GB2435@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mjg@redhat.com, rjw@sisk.pl, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Corentin Chary <corentincj@iksaif.net>, Aaron Lu <aaron.lu@intel.com>, Thomas Renninger <trenn@suse.de>

Hi Dmitry,=20

Thanks for your review and suggestions first!

=E6=96=BC =E4=B8=80=EF=BC=8C2013-04-22 =E6=96=BC 21:12 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> On Mon, Apr 22, 2013 at 08:39:15PM +0800, Chun-Yi Lee wrote:
> > From: "Lee, Chun-Yi" <jlee@suse.com>
> > +static acpi_status
> > +find_video_unregister_backlight(acpi_handle handle, u32 lvl, void =
*context,
> > +				void **rv)
> > +{
> > +	struct acpi_device *acpi_dev;
> > +	struct acpi_video_bus *video =3D NULL;
>=20
> Gratuitous initialization of local variables prevents compiler from
> warning when you using variable uninitialized.

Yes, I agreed should not put gratuitous initialization, I will remove i=
t
in v2 patch.

>=20
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
> > +		}
> > +		mutex_unlock(&video->device_list_lock);
> > +		acpi_video_bus_start_devices(video);
> > +	}
> > +	return AE_OK;
> > +}
> > +
> > +void acpi_video_backlight_unregister(void)
> > +{
> > +	if (!register_count) {
>=20
> Locking? It looks like the rest of the driver ignores locking too...

Did you mean locking video_device_list?=20

The acpi/video locks video_device_list when add, remove and notify acpi
video bus driver. It always do the mutex lock before control
video_device_list, so I also add lock when unregister all backlight of
devices.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
