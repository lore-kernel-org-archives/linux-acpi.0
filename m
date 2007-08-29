From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH -mm 0/3] PM: Improve ACPI handling during suspend and hibernation (rev. 3)
Date: Thu, 30 Aug 2007 00:31:25 +0200
Message-ID: <200708300031.26699.rjw@sisk.pl>
References: <200708272347.45438.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55602 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760777AbXH2WUd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Aug 2007 18:20:33 -0400
In-Reply-To: <200708272347.45438.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>

On Monday, 27 August 2007 23:47, Rafael J. Wysocki wrote:
> Hi,
>=20
> The patches in this series are intended to improve the handling of th=
e ACPI
> platform during suspend and hibernation.
>=20
> They do the following things:
> * make hibernation_platform_enter() consistent with the sleep state e=
ntering
> =A0 code in kernel/power/main.c
> * introduce global platform callbacks allowing us to handle ACPI in a=
 more fine
> =A0 grained way during suspend and hibernation
> * improve the handling of the system status indicator during suspend =
and
> =A0 hibernation.

Please regard this patch series as withdrawn.

I have found a corner case that requires special treatment clashing wit=
h the
2/3 and 3/3 patches and the 1/3 patch will be resubmitted separately.

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
