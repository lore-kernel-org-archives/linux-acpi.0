From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 1/7] acpi: add a way to promote/demote vendor backlight drivers
Date: Fri, 29 Jun 2012 14:19:04 +0200
Message-ID: <CAHR064i0J32kpOh3v2SMhVQ=wofkm5wyiPRwyJOzqwMq+y3LPA@mail.gmail.com>
References: <1339572727-24744-1-git-send-email-corentin.chary@gmail.com>
	<1339572727-24744-2-git-send-email-corentin.chary@gmail.com>
	<20120626221907.GC26614@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120626221907.GC26614@kamineko.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 27, 2012 at 12:19 AM, Mattia Dongili <malattia@linux.it> wr=
ote:
> Hi Corentin,
>
> On Wed, Jun 13, 2012 at 09:32:01AM +0200, Corentin Chary wrote:
> ...
>> +/* Promote the vendor interface instead of the generic video module=
=2E
>> + * This function allow DMI blacklists to be implemented by external=
s
>> + * platform drivers instead of putting a big blacklist in video_det=
ect.c
>> + * After calling this function you will probably want to call
>> + * acpi_video_unregister() to make sure the video module is not loa=
ded
>> + */
>> +void acpi_video_dmi_promote_vendor(void)
>> +{
>> + =C2=A0 =C2=A0 acpi_video_caps_check();
>> + =C2=A0 =C2=A0 acpi_video_support |=3D ACPI_VIDEO_BACKLIGHT_DMI_VEN=
DOR;
>> +}
>> +EXPORT_SYMBOL(acpi_video_dmi_promote_vendor);
>
> I think having the promote_vendor() function do the sanity check on t=
he
> acpi_backlight parameter and the unregistering of the acpi_video devi=
ce
> may make the code cleaner and more acpi_video-agnostic in the drivers=
=2E
> I.e. (untested sample code):
>
> bool acpi_video_promote_vendor(void)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (acpi_video_backlight_support())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_video_support |=3D ACPI_VIDEO_BACKLIG=
HT_DMI_VENDOR;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info("Disabling ACPI video driver\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_video_unregister();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;
> }
> EXPORT_SYMBOL(acpi_video_promote_vendor);
>
> and in the drivers you do
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (my_drv->broken_acpi_video) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (acpi_video=
_promote_vendor())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0do_backlight_init();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!acpi_video_backlight_support()=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_backlight_i=
nit();
>
> or something along these lines.
> If you give a boolean parameter to acpi_video_promote_vendor to force
> vendor backlight we could make the drivers' code even simpler but tha=
t
> would change the semantics of the "promotion" to something more of a
> "take-over".
>
> PS: I will need to promote backlight control in sony-laptop.ko
> eventually as well but I don't have a DMI based list but rather I sho=
uld
> look at a specific handle (or say Method) presence in the SNC Device.
> I guess I'm just bothered by the function naming here but not a big
> deal. :)
> --
> mattia
> :wq!

I had something like that in mind, but it makes acpi.ko use symbols
from video.ko, and video.ko already uses symbols from acpi.ko, and I
didn't want to mess with circular dependencies. But if you manage to
make it work, and if you want to remove dmi_, I'll hapilly Ack it !



--=20
Corentin Chary
http://xf.iksaif.net
