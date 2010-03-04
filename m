From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] ACPI / PM: Move ACPI video resume to a PM notifier
Date: Thu, 4 Mar 2010 12:11:06 +0100
Message-ID: <b170af451003040311g3cea44caj1cd0e23e55814696@mail.gmail.com>
References: <201003040125.30091.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:44625 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375Ab0CDLLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2010 06:11:08 -0500
In-Reply-To: <201003040125.30091.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

2010/3/4 Rafael J. Wysocki <rjw@sisk.pl>:
> There is a problem with the ACPI video resume routine that it's
> executed before the GPU that may be accessed by it. =C2=A0To fix this
> issue, move the ACPI video resume to a power management notifier,
> so that it's executed after resuming all devices, including the GPU.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Tested-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>

It partially fixes bugzilla bug #15096 and it first needed step to fix
it completely.

Can we send this to stable for .32 and .33?

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
