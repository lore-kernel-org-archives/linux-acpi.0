From: Wolfram Gloger <wmglo-icbQPRvlPmzsFLaNRtWx27DyIQmqzodN@public.gmane.org>
Subject: Re: [repost w/ PATCH] Wrong initialization in mp_config_acpi_legacy_irqs()
Date: Mon, 23 Jun 2003 15:30:19 +0200 (MDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200306231330.PAA10035@max.zk-i.med.uni-muenchen.de>
References: <200306231232.OAA10526@max.zk-i.med.uni-muenchen.de> <20030623130827.GD2620@parcelfarce.linux.theplanet.co.uk> <200306231314.PAA10134@max.zk-i.med.uni-muenchen.de> <20030623131752.GE2620@parcelfarce.linux.theplanet.co.uk>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030623131752.GE2620-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
	(message from Matthew Wilcox on Mon, 23 Jun 2003 14:17:52 +0100)
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> this is Linux, not software engineering 101.  0xffffffff is the bitpattern
> for (int) -1 on all Linux platforms.  And this is even in i386-specific
> code.

Yuck.

I still find the for() loop by far more clear, even with portability
set aside.  And is probably more efficient, too, since unlike memset()
it does not have to check for alignment constraints.

Anyway, I don't care how the bug is fixed in the end.

Regards,
Wolfram.


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
