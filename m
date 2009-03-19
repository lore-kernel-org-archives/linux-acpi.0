From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Thu, 19 Mar 2009 21:44:37 +0000
Message-ID: <20090319214437.GB24898@srcf.ucam.org>
References: <20090319212123.GA24700@srcf.ucam.org> <20090319213428.GK29624@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33104 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757681AbZCSVon (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 17:44:43 -0400
Content-Disposition: inline
In-Reply-To: <20090319213428.GK29624@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Thu, Mar 19, 2009 at 10:34:28PM +0100, Norbert Preining wrote:
> HI Matthew,
>=20
> On Do, 19 M=E4r 2009, Matthew Garrett wrote:
> > Enable events on all Vaio's with the new-style ACPI interface, and =
use
> > it to support rfkill where available.
>=20
> Thanks for these patches, do they enable wwan activation on Vaio Z
> series, too?

I expect so.

> Currently the stock kernel sony-laptop with all patches floating arou=
nd
> on lkml did not make the wwan interface show up from the turned off
> state. The only way to do that is using the 0.6 version for Vaio Z fr=
om
> http://www.basyskom.org/~eva/log_installation_vaio_z21vnx.html

Sigh. I could have saved some amount of time if these patches had=20
actually been sent to the mailing list. They're functionally equivalent=
,=20
except mine integrate with the rfkill class correctly and check whether=
=20
the hardware is present before creating the rfkill device.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
