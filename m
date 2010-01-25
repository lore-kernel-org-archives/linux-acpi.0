From: luke lin <luke.lin1105@gmail.com>
Subject: Question about ACPI Video
Date: Mon, 25 Jan 2010 17:45:03 +0800
Message-ID: <d292941c1001250145o43dc2785p6cdc7d2ff6d47e76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f182.google.com ([209.85.221.182]:52799 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab0AYJpH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Jan 2010 04:45:07 -0500
Received: by qyk12 with SMTP id 12so1827033qyk.21
        for <linux-acpi@vger.kernel.org>; Mon, 25 Jan 2010 01:45:04 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Luke lin <luke1105@gmail.com>

Hi all,

I read the drivers/acpi/video.c:

895 =A0 =A0 =A0 =A0 result =3D acpi_video_device_lcd_set_level(device, =
max_level);
896 =A0 =A0 =A0 =A0 if (result)
897 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_levels;
898
899 =A0 =A0 =A0 =A0 result =3D acpi_video_device_lcd_get_level_current(=
device, &level);
900 =A0 =A0 =A0 =A0 if (result)
901 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_levels;
902
903 =A0 =A0 =A0 =A0 br->flags._BQC_use_index =3D (level =3D=3D max_leve=
l ? 0 : 1);
904
905 =A0 =A0 =A0 =A0 if (!br->flags._BQC_use_index) {
912 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 2; i < br->count; i++)
913 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (level_old =3D=3D=
 br->levels[i])
914 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lev=
el =3D level_old;
915 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto set_level;
916 =A0 =A0 =A0 =A0 }
why after level =3D=3D max_level, it will still need set_level again?
is this a bug, or it is necessary.

thx
luke
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
