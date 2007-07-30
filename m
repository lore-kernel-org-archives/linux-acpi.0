From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Frequency scaling, Dell Inspiron 6000
Date: Mon, 30 Jul 2007 19:01:11 +0100
Message-ID: <20070730180111.GA6881@srcf.ucam.org>
References: <46AC9E33.3020008@molgaard.org> <20070730004423.GA27398@srcf.ucam.org> <46ADE700.6070400@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-32-9-130.no-dns-yet.enta.net ([78.32.9.130]:60467 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S966099AbXG3SBY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jul 2007 14:01:24 -0400
Content-Disposition: inline
In-Reply-To: <46ADE700.6070400@molgaard.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sune =?iso-8859-1?Q?M=F8lgaard?= <sune@molgaard.org>
Cc: linux-acpi@vger.kernel.org

On Mon, Jul 30, 2007 at 03:26:24PM +0200, Sune M=F8lgaard wrote:

> If I had bought the laptop today and encountered the problems, I woul=
d=20
> probably reach the same conclusion as you, but IIRC powernowd doesn't=
=20
> cooperate with p4-clockmod, and it was a kernel upgrade that made it=20
> complain.

powernowd works fine with p4-clockmod, but that doesn't change the majo=
r=20
point - Celerons don't support any form of Speedstep.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
