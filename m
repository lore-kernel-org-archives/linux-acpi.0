From: Jeremie Tamburini <jeremie.tamburini@gmail.com>
Subject: Re: BUG REPORT backlight acpi: Brightness shortcuts don't work on
 Fujitsu
Date: Wed, 04 Jun 2014 11:15:42 +0200
Message-ID: <538EE3BE.4010809@gmail.com>
References: <538D7845.9010305@gmail.com> <538D80C4.5080901@intel.com> <538D91B4.7050209@gmail.com> <538E85C7.5030809@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:63524 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbaFDJPp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2014 05:15:45 -0400
Received: by mail-we0-f172.google.com with SMTP id k48so8218051wev.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Jun 2014 02:15:44 -0700 (PDT)
In-Reply-To: <538E85C7.5030809@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org

Il 04/06/2014 04:34, Aaron Lu ha scritto:
> Ah, OK, I think I have misunderstood you.
> So you already have a workaround with a xorg.conf file and everything
> works now, right?

Yes, there=E2=80=99s already the xorg workaround which makes the bright=
ness hot=20
keys work. In any case I've collected all the hardware/software infos=20
without any workaround, so to get informations related to the original=20
system setup.

> If that is the case, the only thing that needs to be
> done is to add your system into the video module's DMI table so that =
the
> acpi_video interface will not be created. This can be verified by add=
ing
> video.use_native_backlight=3D1 to kernel cmdline.

Good, just tried video.use_native_backlight=3D1 parameter and it works.=
 It=20
makes the Fn+F6/Fn+F7 work.


Regards
Jeremie
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
