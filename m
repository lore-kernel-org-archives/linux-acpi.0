From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Wed, 15 Jul 2009 12:41:33 +0200
Message-ID: <87ocrm6xeq.fsf@basil.nowhere.org>
References: <1247643512.26272.74.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:43032 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbZGOKli (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 06:41:38 -0400
In-Reply-To: <1247643512.26272.74.camel@rzhang-dt> (Zhang Rui's message of "Wed, 15 Jul 2009 15:38:32 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>

Zhang Rui <rui.zhang@intel.com> writes:
>
> Currently, in order to make sure that it won't bring any side effects=
,
> I only convert the ACPI battery and i8042 to use this framework, whic=
h reduces
> 0.5s+ S3 time(suspend time plus resume time)=EF=BB=BF, from 7.0s to l=
ess than 6.5s.

10.5s+ was intended I guess?

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
