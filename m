From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] ACPI / Video: blacklist some samsung laptops
Date: Sun, 19 Feb 2012 20:56:05 +0100
Message-ID: <CAHR064iXr5Z1WNdD=rjn_ACDEX8EaRgrCg0hj1U=c=Lz9rN__A@mail.gmail.com>
References: <1326784098-3244-1-git-send-email-corentincj@iksaif.net>
	<CAHR064jyOYaRUjZp370ewLGQSKAhhB7gZ4PS7Feb_AzBLGi1tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHR064jyOYaRUjZp370ewLGQSKAhhB7gZ4PS7Feb_AzBLGi1tA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Andrzej Prochyra <andrzej@prochyra.name>, Matthew Garrett <mjg59@srcf.ucam.org>, David Herrmann <dh.herrmann@googlemail.com>, =?UTF-8?Q?Richard_Sch=C3=BCtz?= <r.schtz@t-online.de>, Seth Forshee <seth.forshee@canonical.com>, linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2012 at 9:26 AM, Corentin Chary
<corentin.chary@gmail.com> wrote:
> On Tue, Jan 17, 2012 at 8:08 AM, Corentin Chary <corentincj@iksaif.ne=
t> wrote:
>> On these laptops, the ACPI video is not functional, and very unlikel=
y
>> to be fixed by the vendor. Note that intel_backlight works for some
>> of these laptops, and the backlight from samsung-laptop always work.
>>
>> The good news is that newer laptops have functional ACPI video devic=
e
>> and won't end up growing this list.
>>
>> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
>> ---
>> =C2=A0drivers/acpi/video_detect.c | =C2=A0 49 ++++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A01 files changed, 49 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect=
=2Ec
>> index 45d8097..66be45e 100644
>> --- a/drivers/acpi/video_detect.c
>> +++ b/drivers/acpi/video_detect.c
>> @@ -132,6 +132,53 @@ find_video(acpi_handle handle, u32 lvl, void *c=
ontext, void **rv)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return AE_OK;
>> =C2=A0}
>>
>> +/* Force to use vendor driver when the ACPI device is known to be
>> + * buggy */
>> +static int video_detect_force_vendor(const struct dmi_system_id *d)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 acpi_video_support |=3D ACPI_VIDEO_BACKLIGHT_=
DMI_VENDOR;
>> + =C2=A0 =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static struct dmi_system_id video_detect_dmi_table[] =3D {
>> + =C2=A0 =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vendor=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident =3D "N150P",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS=
_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRO=
DUCT_NAME, "N150P"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_BOA=
RD_NAME, "N150P"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vendor=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident =3D "N145P/N250P/N260P",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS=
_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRO=
DUCT_NAME, "N145P/N250P/N260P"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_BOA=
RD_NAME, "N145P/N250P/N260P"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vendor=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident =3D "N150/N210/N220",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS=
_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRO=
DUCT_NAME, "N150/N210/N220"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_BOA=
RD_NAME, "N150/N210/N220"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.callback =3D video_detect_force_vendor=
,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.ident =3D "NF110/NF210/NF310",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0.matches =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_SYS=
_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_PRO=
DUCT_NAME, "NF110/NF210/NF310"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DMI_MATCH(DMI_BOA=
RD_NAME, "NF110/NF210/NF310"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 =C2=A0 },
>> +};
>> +
>> =C2=A0/*
>> =C2=A0* Returns the video capabilities of a specific ACPI graphics d=
evice
>> =C2=A0*
>> @@ -164,6 +211,8 @@ long acpi_video_get_capabilities(acpi_handle gra=
phics_handle)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dmi_check_system(=
video_detect_dmi_table);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D ac=
pi_bus_get_device(graphics_handle, &tmp_dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ACPI_FAIL=
URE(status)) {
>> --
>> 1.7.5.4
>>
>
> Hi Len,
>
> Maybe this patch should go through your tree and not platform-drivers=
-x86 ?

Ping ?

--=20
Corentin Chary
http://xf.iksaif.net
