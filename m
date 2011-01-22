From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to iomaps management
Date: Sun, 23 Jan 2011 01:24:32 +0800
Message-ID: <AANLkTi=MDyaPj9D+28NWRRK13qhJfKw098xPPhwrGZoa@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl>
	<AANLkTimEoAhO9TRx4Aq7NnTTt6G-u+cHJRyAMjSAJgTm@mail.gmail.com>
	<AANLkTin3d4LdnqDYtrTK=KdmjADA2MsaWYoLG19FxOzG@mail.gmail.com>
	<201101221025.49327.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48454 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab1AVRYd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Jan 2011 12:24:33 -0500
In-Reply-To: <201101221025.49327.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

2011/1/22 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday, January 22, 2011, Jeff Chua wrote:

> means that my patch [11/11] _and_ the replacement are totally wrong, =
because you have
> _multiple_ NVS regions. =A0That really helped, thanks a lot.

Would it be different if I offline all CPUs before suspending to ram?
It seems to help with suspending to disk.

Thanks,
Jeff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
