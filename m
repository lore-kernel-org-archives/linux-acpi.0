From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sun, 22 Mar 2009 20:37:40 +0000
Message-ID: <20090322203740.GA12285@srcf.ucam.org>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40736 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbZCVUhx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2009 16:37:53 -0400
Content-Disposition: inline
In-Reply-To: <20090322203603.GA6877@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Sun, Mar 22, 2009 at 09:36:03PM +0100, Norbert Preining wrote:
> On So, 22 M=E4r 2009, Matthew Garrett wrote:
> > Actually, try this one instead - obvious think in the first one.
>=20
> Tried it but acpi_listen still reports the same events:
> sony/hotkey SNC 00000001 00000090
> sony/hotkey SNC 00000001 00000090

Hm. Try changing 0x93 to 0x90 in the notify handler.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
