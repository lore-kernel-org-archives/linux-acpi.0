From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] ACPI / Video: blacklist some samsung laptops
Date: Mon, 20 Feb 2012 12:06:15 +0100
Message-ID: <CANq1E4TQ0qUrOTNQOmC2K+3zC2_7Om3TcRH=w78VReHat=36+w@mail.gmail.com>
References: <1326784098-3244-1-git-send-email-corentincj@iksaif.net>
	<CAHR064jyOYaRUjZp370ewLGQSKAhhB7gZ4PS7Feb_AzBLGi1tA@mail.gmail.com>
	<CAHR064iXr5Z1WNdD=rjn_ACDEX8EaRgrCg0hj1U=c=Lz9rN__A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHR064iXr5Z1WNdD=rjn_ACDEX8EaRgrCg0hj1U=c=Lz9rN__A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Andrzej Prochyra <andrzej@prochyra.name>, Matthew Garrett <mjg59@srcf.ucam.org>, =?ISO-8859-1?Q?Richard_Sch=FCtz?= <r.schtz@t-online.de>, Seth Forshee <seth.forshee@canonical.com>, linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Len

On Sun, Feb 19, 2012 at 8:56 PM, Corentin Chary
<corentin.chary@gmail.com> wrote:
> On Mon, Jan 30, 2012 at 9:26 AM, Corentin Chary
> <corentin.chary@gmail.com> wrote:
>> On Tue, Jan 17, 2012 at 8:08 AM, Corentin Chary <corentincj@iksaif.n=
et> wrote:
>>> On these laptops, the ACPI video is not functional, and very unlike=
ly
>>> to be fixed by the vendor. Note that intel_backlight works for some
>>> of these laptops, and the backlight from samsung-laptop always work=
=2E
>>>
>>> The good news is that newer laptops have functional ACPI video devi=
ce
>>> and won't end up growing this list.
>>>
>>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>>> ---
>>> =A0drivers/acpi/video_detect.c | =A0 49 +++++++++++++++++++++++++++=
++++++++++++++++
>>> =A01 files changed, 49 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detec=
t.c
>>> index 45d8097..66be45e 100644
>>> --- a/drivers/acpi/video_detect.c
>>> +++ b/drivers/acpi/video_detect.c
>>> @@ -132,6 +132,53 @@ find_video(acpi_handle handle, u32 lvl, void *=
context, void **rv)
>>> =A0 =A0 =A0 =A0return AE_OK;
>>> =A0}
>>>
>>> +/* Force to use vendor driver when the ACPI device is known to be
>>> + * buggy */
>>> +static int video_detect_force_vendor(const struct dmi_system_id *d=
)
>>> +{
>>> + =A0 =A0 =A0 acpi_video_support |=3D ACPI_VIDEO_BACKLIGHT_DMI_VEND=
OR;
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +static struct dmi_system_id video_detect_dmi_table[] =3D {
>>> + =A0 =A0 =A0 {
>>> + =A0 =A0 =A0 =A0.callback =3D video_detect_force_vendor,
>>> + =A0 =A0 =A0 =A0.ident =3D "N150P",
>>> + =A0 =A0 =A0 =A0.matches =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG EL=
ECTRONICS CO., LTD."),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_PRODUCT_NAME, "N150P"),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_BOARD_NAME, "N150P"),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 {
>>> + =A0 =A0 =A0 =A0.callback =3D video_detect_force_vendor,
>>> + =A0 =A0 =A0 =A0.ident =3D "N145P/N250P/N260P",
>>> + =A0 =A0 =A0 =A0.matches =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG EL=
ECTRONICS CO., LTD."),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_PRODUCT_NAME, "N145P/N2=
50P/N260P"),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_BOARD_NAME, "N145P/N250=
P/N260P"),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 {
>>> + =A0 =A0 =A0 =A0.callback =3D video_detect_force_vendor,
>>> + =A0 =A0 =A0 =A0.ident =3D "N150/N210/N220",
>>> + =A0 =A0 =A0 =A0.matches =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG EL=
ECTRONICS CO., LTD."),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_PRODUCT_NAME, "N150/N21=
0/N220"),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_BOARD_NAME, "N150/N210/=
N220"),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 {
>>> + =A0 =A0 =A0 =A0.callback =3D video_detect_force_vendor,
>>> + =A0 =A0 =A0 =A0.ident =3D "NF110/NF210/NF310",
>>> + =A0 =A0 =A0 =A0.matches =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG EL=
ECTRONICS CO., LTD."),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_PRODUCT_NAME, "NF110/NF=
210/NF310"),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMI_MATCH(DMI_BOARD_NAME, "NF110/NF21=
0/NF310"),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>>> + =A0 =A0 =A0 },
>>> +};
>>> +
>>> =A0/*
>>> =A0* Returns the video capabilities of a specific ACPI graphics dev=
ice
>>> =A0*
>>> @@ -164,6 +211,8 @@ long acpi_video_get_capabilities(acpi_handle gr=
aphics_handle)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0ACPI_V=
IDEO_BACKLIGHT_DMI_VENDOR;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmi_check_system(video_detect_dmi_tab=
le);
>>> =A0 =A0 =A0 =A0} else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D acpi_bus_get_device(graph=
ics_handle, &tmp_dev);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ACPI_FAILURE(status)) {
>>> --
>>> 1.7.5.4
>>>
>>
>> Hi Len,
>>
>> Maybe this patch should go through your tree and not platform-driver=
s-x86 ?
>
> Ping ?

This is actually a regression on Samsung notebooks as the backlight is
no longer working with linux-3.2. It would be really nice to see this
in the stable branch or at least in linux-3.3.

The samsung driver disables its own backlight driver if ACPI core
handles the backlight since linux-3.2. If you don't want to pickup
this patch it would be nice to see the samsung driver fixing this
issue.

Regards
David

> --
> Corentin Chary
> http://xf.iksaif.net
