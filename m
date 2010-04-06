From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [GIT pull request] ACPI patches for 2.6.34-rc3
Date: Tue, 6 Apr 2010 09:25:38 +0200
Message-ID: <h2ub170af451004060025oe838072pada57b715e18c235@mail.gmail.com>
References: <alpine.LFD.2.00.1004060308030.21994@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:36734 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757280Ab0DFHZk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:25:40 -0400
In-Reply-To: <alpine.LFD.2.00.1004060308030.21994@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

W dniu 6 kwietnia 2010 09:09 u=C5=BCytkownik Len Brown <lenb@kernel.org=
> napisa=C5=82:
> commit c8cf3a14a6615e06504664cd50ca90baa5f2ef7d
> Author: Rafael Wysocki <rjw@sisk.pl>
> Date: =C2=A0 Thu Mar 4 00:25:30 2010 +0000
>
> =C2=A0 =C2=A0ACPI / PM: Move ACPI video resume to a PM notifier
>
> =C2=A0 =C2=A0There is a problem with the ACPI video resume routine th=
at it's
> =C2=A0 =C2=A0executed before the GPU that may be accessed by it. =C2=A0=
To fix this
> =C2=A0 =C2=A0issue, move the ACPI video resume to a power management =
notifier,
> =C2=A0 =C2=A0so that it's executed after resuming all devices, includ=
ing the GPU.
>
> =C2=A0 =C2=A0http://bugzilla.kernel.org/show_bug.cgi?id=3D15096
>
> =C2=A0 =C2=A0Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> =C2=A0 =C2=A0Acked-by: Matthew Garrett <mjg@redhat.com>
> =C2=A0 =C2=A0Tested-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> =C2=A0 =C2=A0Signed-off-by: Len Brown <len.brown@intel.com>

Could you push this one to stable as well, please? It partially fixes
regression reported in:
https://bugzilla.kernel.org/show_bug.cgi?id=3D15096

This should go to .32 and .33.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
