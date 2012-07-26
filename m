From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 08/16] Thermal: Remove tc1/tc2 in generic thermal
 layer.
Date: Thu, 26 Jul 2012 10:23:08 +0800
Message-ID: <1343269388.1682.401.camel@rui.sh.intel.com>
References: <1343182273-32096-1-git-send-email-rui.zhang@intel.com>
	 <1343182273-32096-9-git-send-email-rui.zhang@intel.com>
	 <201207252224.06694.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42917 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab2GZCVv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2012 22:21:51 -0400
In-Reply-To: <201207252224.06694.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, R Durgadoss <durgadoss.r@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Kachhap <amit.kachhap@linaro.org>, Wei Ni <wni@nvidia.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On =E4=B8=89, 2012-07-25 at 22:24 +0200, Rafael J. Wysocki wrote:
> First, it would be good to write something about the motivation here.
>=20
> Second, I suppose that there are no users of the code in question who
> rely on the current behavior except for ACPI.  If that is the case, i=
t
> should be state in the changelog too, because that's an important pie=
ce
> of information for whoever wants to understand what's going on.  If
> that is not the case, however, you should describe how your changes w=
ill
> affect the users in question, so that it's clear enough that no regre=
ssions
> will result from this change.
>=20
yep, but I think I should state this in the previous patch, when
introducing .get_trend() callback.
This patch just does some cleanups.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
