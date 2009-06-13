From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [Intel-gfx] RFC] [Patch] [DRM/I915] :Check the LID device to
	decide whether the LVDS should be initialized
Date: Sat, 13 Jun 2009 11:48:15 +0600
Message-ID: <c072ca310906122248w62683eb4waad8fd0be49b20@mail.gmail.com>
References: <1244187921.3558.223.camel@localhost.localdomain>
	 <1244200261.11142.20.camel@gaiman.anholt.net>
	 <1244422347.3698.6.camel@localhost.localdomain>
	 <1244585813.4896.34.camel@gaiman.anholt.net>
	 <20090609153559.2e93479d@jbarnes-x200>
	 <1244714614.3618.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:38103 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZFMFsO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2009 01:48:14 -0400
Received: by bwz9 with SMTP id 9so2437203bwz.37
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2009 22:48:15 -0700 (PDT)
In-Reply-To: <1244714614.3618.10.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, rui.zhang@intel.com, linux-acpi@vger.kernel.org

2009/6/11 yakui_zhao <yakui.zhao@intel.com>:
> + =C2=A0 =C2=A0 =C2=A0 if (acpi_disabled) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if ACPI is=
 disabled, there is no ACPI device tree. And
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* we don't k=
now whether there exists the LID device.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In such ca=
se we will return 0.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }

Won't this prevent people from debugging ACPI problems on laptops by
disabling ACPI on the kernel command line? Does this patch mean that,
in such case, there will be no output at all? Maybe, without ACPI, we
should initialize LVDS if and only if there are no other output
devices connected?

--=20
Alexander E. Patrakov
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
