From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] ACPI/Thermal: Remove the unused lock of struct acpi_thermal
Date: Tue, 20 Aug 2013 01:39:33 +0200
Message-ID: <3496699.ZyzxTjCB8h@vostro.rjw.lan>
References: <1376485239-18312-1-git-send-email-tianyu.lan@intel.com> <4D68720C2E767A4AA6A8796D42C8EB59D135EA@BGSMSX103.gar.corp.intel.com> <520C20CA.5060403@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50413 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab3HSX3A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Aug 2013 19:29:00 -0400
In-Reply-To: <520C20CA.5060403@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

On Thursday, August 15, 2013 08:28:58 AM Lan Tianyu wrote:
> On 2013=E5=B9=B408=E6=9C=8815=E6=97=A5 01:05, R, Durgadoss wrote:
> >=20
> >> -----Original Message-----
> >> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> >> owner@vger.kernel.org] On Behalf Of tianyu.lan@intel.com
> >> Sent: Wednesday, August 14, 2013 6:31 PM
> >> To: rjw@sisk.pl; lenb@kernel.org
> >> Cc: Lan, Tianyu; linux-acpi@vger.kernel.org; Zhang, Rui
> >> Subject: [PATCH 1/3] ACPI/Thermal: Remove the unused lock of struc=
t
> >> acpi_thermal
> >>
> >> From: Lan Tianyu <tianyu.lan@intel.com>
> >>
> >> The acpi_thermal->lock now just is initialized when thermal zone d=
evice
> >> is added and destroyed when thermal zone is removed. Never being u=
sed
> >> any other places. So remove it.
> >>
> >=20
> > Hi Tianyu,
> >=20
> > Very Nice catch. All three patches look fine to me.
> > For all three,
> > Acked-by: Durgadoss R <durgadoss.r@intel.com>
>=20
> Thanks for Acks.

Whole series queued up for 3.12.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
