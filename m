From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 16/16] Thermal: Introduce locking for
 cdev.thermal_instances list.
Date: Thu, 26 Jul 2012 10:32:28 +0800
Message-ID: <1343269948.1682.406.camel@rui.sh.intel.com>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
	 <1343182273-32096-17-git-send-email-rui.zhang@intel.com>
	 <201207252054.14648.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26581 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144Ab2GZCbM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 22:31:12 -0400
In-Reply-To: <201207252054.14648.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hi, Rafael,

On =E4=B8=89, 2012-07-25 at 20:54 +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 25, 2012, Zhang Rui wrote:
>=20
> Can you please say something about the motivation in the changelog?
>=20
sure.
I just thought that the subject is enough illustrating the problem.
will fix it.

thanks for your comments on this!

-rui
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
