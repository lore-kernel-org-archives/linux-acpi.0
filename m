From: Edward Shao <laface.tw@gmail.com>
Subject: Re: Question about ACPI Video
Date: Thu, 28 Jan 2010 02:02:40 +0800
Message-ID: <ff05f3d01001271002o19135ab7g10b7118be8d85976@mail.gmail.com>
References: <d292941c1001250145o43dc2785p6cdc7d2ff6d47e76@mail.gmail.com>
	 <1264467484.22448.310.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f186.google.com ([209.85.223.186]:40163 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab0A0SCm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2010 13:02:42 -0500
Received: by iwn16 with SMTP id 16so353355iwn.5
        for <linux-acpi@vger.kernel.org>; Wed, 27 Jan 2010 10:02:41 -0800 (PST)
In-Reply-To: <1264467484.22448.310.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Luke lin <luke1105@gmail.com>

On Tue, Jan 26, 2010 at 8:58 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Mon, 2010-01-25 at 17:45 +0800, luke lin wrote:
>> Hi all,
>>
>> I read the drivers/acpi/video.c:
>>
>> 895 =A0 =A0 =A0 =A0 result =3D acpi_video_device_lcd_set_level(devic=
e, max_level);
>> 896 =A0 =A0 =A0 =A0 if (result)
>> 897 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_levels;
>> 898
>> 899 =A0 =A0 =A0 =A0 result =3D acpi_video_device_lcd_get_level_curre=
nt(device, &level);
>> 900 =A0 =A0 =A0 =A0 if (result)
>> 901 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_levels;
>> 902
>> 903 =A0 =A0 =A0 =A0 br->flags._BQC_use_index =3D (level =3D=3D max_l=
evel ? 0 : 1);
>> 904
>> 905 =A0 =A0 =A0 =A0 if (!br->flags._BQC_use_index) {
>> 912 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 2; i < br->count; i++=
)
>> 913 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (level_old =3D=
=3D br->levels[i])
>> 914 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
level =3D level_old;
>> 915 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto set_level;
>> 916 =A0 =A0 =A0 =A0 }
>> why after level =3D=3D max_level, it will still need set_level again=
?
>> is this a bug, or it is necessary.
>>
> Because setting the backlight to max_level is just to check if _BQC u=
ses
> indexed value. We need to set the backlight back after this is done.
>
> thanks,
> rui

Hi~

I'm wondering why check (level =3D=3D max_level) can make sure if _BQC
uses indexed value?
Is it possible that both level and max_level is indexed value?

Thank you very much.

--=20
Best Regards,
Edward
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
