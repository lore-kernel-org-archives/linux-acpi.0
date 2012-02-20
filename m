From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] ACPI / Video: blacklist some samsung laptops
Date: Mon, 20 Feb 2012 15:27:00 +0100
Message-ID: <CAHR064jHMk0WM69xK7_qD5VoGeU6vi88yRkGwGiY1f2R6AQ+Xg@mail.gmail.com>
References: <1326784098-3244-1-git-send-email-corentincj@iksaif.net>
	<CAHR064jyOYaRUjZp370ewLGQSKAhhB7gZ4PS7Feb_AzBLGi1tA@mail.gmail.com>
	<CAHR064iXr5Z1WNdD=rjn_ACDEX8EaRgrCg0hj1U=c=Lz9rN__A@mail.gmail.com>
	<CANq1E4TQ0qUrOTNQOmC2K+3zC2_7Om3TcRH=w78VReHat=36+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CANq1E4TQ0qUrOTNQOmC2K+3zC2_7Om3TcRH=w78VReHat=36+w@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Andrzej Prochyra <andrzej@prochyra.name>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?Q?Richard_Sch=C3=BCtz?= <r.schtz@t-online.de>, Seth Forshee <seth.forshee@canonical.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 20, 2012 at 12:06 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Len
>
> On Sun, Feb 19, 2012 at 8:56 PM, Corentin Chary
> <corentin.chary@gmail.com> wrote:
>> On Mon, Jan 30, 2012 at 9:26 AM, Corentin Chary
>> <corentin.chary@gmail.com> wrote:
>>> On Tue, Jan 17, 2012 at 8:08 AM, Corentin Chary <corentincj@iksaif.=
net> wrote:
>>>> On these laptops, the ACPI video is not functional, and very unlik=
ely
>>>> to be fixed by the vendor. Note that intel_backlight works for som=
e
>>>> of these laptops, and the backlight from samsung-laptop always wor=
k.
>>>>
>>>> The good news is that newer laptops have functional ACPI video dev=
ice
>>>> and won't end up growing this list.
>>>>
>>>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>>>> ---
>>>> =C2=A0drivers/acpi/video_detect.c | =C2=A0 49 ++++++++++++++++++++=
+++++++++++++++++++++++
>>>> =C2=A01 files changed, 49 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_dete=
ct.c
>>>> index 45d8097..66be45e 100644
>>>> --- a/drivers/acpi/video_detect.c
>>>> +++ b/drivers/acpi/video_detect.c
>>>> @@ -132,6 +132,53 @@ find_video(acpi_handle handle, u32 lvl, void =
*context, void **rv)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return AE_OK;
>>>> =C2=A0}
>>>>
>>>> +/* Force to use vendor driver when the ACPI device is known to be
>>>> + * buggy */
>>>> +static int video_detect_force_vendor(const struct dmi_system_id *=
d)
>>>> +{
>>>> + =C2=A0 =C2=A0 =C2=A0 acpi_video_support |=3D ACPI_VIDEO_BACKLIGH=
T_DMI_VENDOR;
>>>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>>>> +}
>>>> +
>>>> +static struct dmi_system_id video_detect_dmi_table[] =3D {
>>>> + =C2=A0 =C2=A0 =C2=A0 {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vend=
or,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident =3D "N150P",
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches =3D {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_S=
YS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_P=
RODUCT_NAME, "N150P"),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_B=
OARD_NAME, "N150P"),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>>>> + =C2=A0 =C2=A0 =C2=A0 },
>>>> + =C2=A0 =C2=A0 =C2=A0 {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vend=
or,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident =3D "N145P/N250P/N260P",
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches =3D {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_S=
YS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_P=
RODUCT_NAME, "N145P/N250P/N260P"),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_B=
OARD_NAME, "N145P/N250P/N260P"),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>>>> + =C2=A0 =C2=A0 =C2=A0 },
>>>> + =C2=A0 =C2=A0 =C2=A0 {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vend=
or,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident =3D "N150/N210/N220",
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches =3D {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_S=
YS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_P=
RODUCT_NAME, "N150/N210/N220"),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_B=
OARD_NAME, "N150/N210/N220"),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>>>> + =C2=A0 =C2=A0 =C2=A0 },
>>>> + =C2=A0 =C2=A0 =C2=A0 {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vend=
or,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident =3D "NF110/NF210/NF310",
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches =3D {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_S=
YS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_P=
RODUCT_NAME, "NF110/NF210/NF310"),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_B=
OARD_NAME, "NF110/NF210/NF310"),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>>>> + =C2=A0 =C2=A0 =C2=A0 },
>>>> +};
>>>> +
>>>> =C2=A0/*
>>>> =C2=A0* Returns the video capabilities of a specific ACPI graphics=
 device
>>>> =C2=A0*
>>>> @@ -164,6 +211,8 @@ long acpi_video_get_capabilities(acpi_handle g=
raphics_handle)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *}
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmi_check_syste=
m(video_detect_dmi_table);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D =
acpi_bus_get_device(graphics_handle, &tmp_dev);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ACPI_FA=
ILURE(status)) {
>>>> --
>>>> 1.7.5.4
>>>>
>>>
>>> Hi Len,
>>>
>>> Maybe this patch should go through your tree and not platform-drive=
rs-x86 ?
>>
>> Ping ?
>
> This is actually a regression on Samsung notebooks as the backlight i=
s
> no longer working with linux-3.2. It would be really nice to see this
> in the stable branch or at least in linux-3.3.
>
> The samsung driver disables its own backlight driver if ACPI core
> handles the backlight since linux-3.2. If you don't want to pickup
> this patch it would be nice to see the samsung driver fixing this
> issue.
>
> Regards
> David

David, please note that non of my changes are merged in 3.2 or 3.3,
they are still in the platform-x86 tree.
But you are right, if they are merged in 3.4 (and I really hope so)
then we will need this patch or there will be a regression.
Anyway, this patch can, and should, be merged as soon as possible
because DE or even xrandr may want to use the non functionnal acpi
backlight instead of others.

Thanks,


--=20
Corentin Chary
http://xf.iksaif.net
