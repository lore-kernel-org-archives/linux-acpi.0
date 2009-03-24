From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Tue, 24 Mar 2009 00:04:53 +0000
Message-ID: <20090324000453.GA1778@srcf.ucam.org>
References: <200903211453.49039.matze@welwarsky.de> <20090322175609.GA10304@srcf.ucam.org> <20090322180321.GA10401@srcf.ucam.org> <20090322203603.GA6877@gamma.logic.tuwien.ac.at> <20090322203740.GA12285@srcf.ucam.org> <20090322220655.GA13887@gamma.logic.tuwien.ac.at> <20090322224652.GA13814@srcf.ucam.org> <20090322231029.GC17905@kamineko.org> <20090323214822.GA32460@srcf.ucam.org> <20090324000200.GB15580@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37618 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbZCXAFA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2009 20:05:00 -0400
Content-Disposition: inline
In-Reply-To: <20090324000200.GB15580@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Mattia Dongili <malattia@linux.it>, Matthias Welwarsky <matze@welwarsky.de>, linux-acpi@vger.kernel.org

On Tue, Mar 24, 2009 at 01:02:00AM +0100, Norbert Preining wrote:
> On Mo, 23 M=E4r 2009, Matthew Garrett wrote:
> > Interestingly, the recent SRs also appear to implement the 0x124 rf=
ill=20
> > method, but at SN07(4) rather than SN07(3). This leaves me pretty h=
appy=20
> > that I've got the right idea about how this all works now :)
> >=20
> > diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/=
x86/sony-laptop.c
> > index 2d142d3..5d95af8 100644
>=20
> So does that mean I should test this on on top of your "final" patch?

The Z series doesn't implement the 0x127 method, so it won't make any=20
difference.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
