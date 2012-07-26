From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 04/16] Thermal: Introduce multiple cooling states
 support
Date: Thu, 26 Jul 2012 10:33:02 +0800
Message-ID: <1343269982.1682.407.camel@rui.sh.intel.com>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
	 <1343182273-32096-5-git-send-email-rui.zhang@intel.com>
	 <201207252206.16897.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46039 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab2GZCcO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 22:32:14 -0400
In-Reply-To: <201207252206.16897.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On =E4=B8=89, 2012-07-25 at 22:06 +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 25, 2012, Zhang Rui wrote:
> > This is because general active cooling devices, like fans,
> > may have multiple speeds, which can be mapped to different cooling =
states.
> >=20
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>=20
> Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
>=20
again, thanks for reviewing this patch set, Rafael!

-rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
