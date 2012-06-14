From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/7] drivers-platform-x86: use acpi_video_dmi_promote_vendor()
Date: Thu, 14 Jun 2012 12:54:05 +0200
Message-ID: <CAHR064i_0vunKzB_Yg9SGrWQcPxJs2sTekWk6LuP2qf0FEqBOQ@mail.gmail.com>
References: <1339572727-24744-1-git-send-email-corentin.chary@gmail.com>
	<1339572727-24744-3-git-send-email-corentin.chary@gmail.com>
	<1339667937.9598.97.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61220 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab2FNKyH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2012 06:54:07 -0400
In-Reply-To: <1339667937.9598.97.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Joey Lee <jlee@novell.com>, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org

On Thu, Jun 14, 2012 at 11:58 AM, joeyli <jlee@suse.com> wrote:
> Hi Corentin,
>
> =E6=96=BC =E4=B8=89=EF=BC=8C2012-06-13 =E6=96=BC 09:32 +0200=EF=BC=8C=
Corentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
>> Instead of using directly acpi_video_unregister(), use
>> acpi_video_dmi_promote_vendor() (and make it call
>> acpi_video_unregister() if needed)
>>
>> Signed-off-by: Corentin Chary <corentin.chary@gmail.com>
>> ---
>> =C2=A0drivers/platform/x86/acer-wmi.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
16 +++++++++-------
>> =C2=A0drivers/platform/x86/apple-gmux.c =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
6 ++++++
>> =C2=A0drivers/platform/x86/samsung-laptop.c | =C2=A0 22 ++++++++++++=
----------
>> =C2=A03 files changed, 27 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/=
acer-wmi.c
>> index ce875dc..ffc53df 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -2060,14 +2060,16 @@ static int __init acer_wmi_init(void)
>>
>> =C2=A0 =C2=A0 =C2=A0 set_quirks();
>>
>> + =C2=A0 =C2=A0 if (dmi_check_system(video_vendor_dmi_table))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_video_dmi_promote_v=
endor();
>> =C2=A0 =C2=A0 =C2=A0 if (acpi_video_backlight_support()) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dmi_check_system(vid=
eo_vendor_dmi_table)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 acpi_video_unregister();
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 interface->capability &=3D ~ACER_CAP_BRIGHTNESS;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pr_info("Brightness must be controlled by "
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "acpi video driver\n");
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interface->capability &=3D=
 ~ACER_CAP_BRIGHTNESS;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("Brightness must=
 be controlled by acpi video driver\n");
>> + =C2=A0 =C2=A0 } else {
>> +#ifdef CONFIG_ACPI_VIDEO
>
> The 'ifdef CONFIG_ACPI_VIDEO' didn't work on my machine with v3.4
> kernel, the acpi video didn't unregister.
>
> My autoconf.h like following:
>
> include/generated/autoconf.h:#define CONFIG_ACPI_VIDEO_MODULE 1
>
>
> Need use:
>
> -#ifdef CONFIG_ACPI_VIDEO
> +#if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_info("Disabling ACPI video driver\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_video_unregister();
> #endif
>
> I tested the above change works to me.

I checked include/acpi/video.h and I could in fact remove all #ifdef st=
uff...
Thanks ! Will update the patches.


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
