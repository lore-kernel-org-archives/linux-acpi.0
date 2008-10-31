From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Build error with latest kernel
Date: Fri, 31 Oct 2008 10:45:22 +0800
Message-ID: <1225421122.2665.18.camel@rzhang-dt>
References: <1225377756.3689.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32582 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096AbYJaCqR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Oct 2008 22:46:17 -0400
In-Reply-To: <1225377756.3689.5.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, mjg@redhat.com

hi,

On Thu, 2008-10-30 at 22:42 +0800, Steven Whitehouse wrote:
> Hi,
>=20
> There is a build error with the attached config on the latest upstrea=
m
> Linus kernel.
>=20
>   CC [M]  drivers/gpu/drm/i915/i915_suspend.o
> drivers/gpu/drm/i915/i915_opregion.c: In function =E2=80=98intel_opre=
gion_init=E2=80=99:
> drivers/gpu/drm/i915/i915_opregion.c:340: error: implicit declaration=
 of
> function =E2=80=98register_acpi_notifier=E2=80=99
> drivers/gpu/drm/i915/i915_opregion.c: In function =E2=80=98intel_opre=
gion_free=E2=80=99:
> drivers/gpu/drm/i915/i915_opregion.c:361: error: implicit declaration=
 of
> function =E2=80=98unregister_acpi_notifier=E2=80=99
> make[4]: *** [drivers/gpu/drm/i915/i915_opregion.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>=20
> Looks like the symbols are not defined when ACPI is not configured.
>=20
=EF=BB=BFYes, you're right.
IGD OpeRegion depends on ACPI.
I think we need to introduce a new kernel config option for
IGD OpRegion support.

cc matthew.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
