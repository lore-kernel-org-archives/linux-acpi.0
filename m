From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/2] Give ACPI hwmon thermal devices a name if BIOS
 provides one
Date: Mon, 25 Aug 2008 09:44:16 +0200
Message-ID: <20080825094416.1dc9dc79@hyperion.delvare>
References: <20080821174852.0689681d@hyperion.delvare>
	<1219615897-21130-3-git-send-email-trenn@suse.de>
	<1219629496.24775.22.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:25278 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbYHYHo3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Aug 2008 03:44:29 -0400
In-Reply-To: <1219629496.24775.22.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org

Hi Thomas,

On Mon, 25 Aug 2008 09:58:16 +0800, Zhang Rui wrote:
> On Mon, 2008-08-25 at 06:11 +0800, Thomas Renninger wrote:
> > diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/therma=
l_sys.c
> > index fe07462..51a7077 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -371,8 +371,15 @@ thermal_add_hwmon_sysfs(struct
> > thermal_zone_device *tz)
> >         tz->hwmon =3D hwmon;
> >         hwmon->count++;
> >=20
> > -       snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
> > -                "temp%d_input", hwmon->count);
> > +       /*
> > +        * What happens if we get duplicate zone names from the BIO=
S?
> > +        * Is that allowed? If not, should we still just add the
> > +        * hwmon count at the end?
> > +        * tz->temp_input.name is char[16], this is ugly to do...
> > +        */
> > +       if (!tz->temp_input.name)
> > +               snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
> > +                        "temp%d_input", hwmon->count);
>
> we should create a new attribute here rather than replacing the old o=
ne.
> the new hwmon sysfs I/F should be like:
> temp1_input:	current temperature
> temp1_crit:	critical threshold
> temp1_label:	string like "=EF=BB=BFProcessor Thermal Zone"

Rui is correct here, you don't want to use the string as a file name
(what your patch is currently doing) but provide it to libsensors
(amongst others) as the contents of a separate file (tempN_label.)
libsensors needs these standard file names, otherwise it can't guess
which is what.

--=20
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
