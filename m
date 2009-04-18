From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH 1/2] toshiba-acpi: Add support for hotkey notifications
Date: Sat, 18 Apr 2009 09:47:25 +0400
Message-ID: <E1Lv3Or-000CHe-00.arvidjaar-mail-ru@mx38.mail.ru>
References: <20090331214501.GC29489@srcf.ucam.org> <alpine.LFD.2.00.0904180000330.30751@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx38.mail.ru ([94.100.176.52]:64365 "EHLO mx38.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbZDRFrk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Apr 2009 01:47:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Len Brown wrote:

> drivers/platform/x86/toshiba_acpi.c:854: warning: passing argument 3 =
of
> =E2=80=98acpi_install_notify_handler=E2=80=99 from incompatible point=
er type
> drivers/platform/x86/toshiba_acpi.c:903: warning: passing argument 3 =
of
> =E2=80=98acpi_remove_notify_handler=E2=80=99 from incompatible pointe=
r type

Patch was here:

http://marc.info/?l=3Dlinux-acpi&m=3D123636477425172&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
