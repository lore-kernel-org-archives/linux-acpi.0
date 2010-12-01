From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 12/13] ACPI / PM: Drop acpi_bus_get_power()
Date: Wed, 1 Dec 2010 23:07:30 +0100
Message-ID: <201012012307.30539.rjw@sisk.pl>
References: <201011250001.11297.rjw@sisk.pl> <201011250012.06151.rjw@sisk.pl> <alpine.LFD.2.00.1012011702210.2314@x980>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46114 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653Ab0LAWIQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Dec 2010 17:08:16 -0500
In-Reply-To: <alpine.LFD.2.00.1012011702210.2314@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Maciej Rutecki <maciej.rutecki@gmail.com>

On Wednesday, December 01, 2010, Len Brown wrote:
>   CC [M]  drivers/platform/x86/fujitsu-laptop.o
> drivers/platform/x86/fujitsu-laptop.c: In function =E2=80=98acpi_fuji=
tsu_add=E2=80=99:
> drivers/platform/x86/fujitsu-laptop.c:692: error: implicit declaratio=
n of=20
> function =E2=80=98acpi_bus_get_power=E2=80=99

Please see:

https://patchwork.kernel.org/patch/360022/

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
