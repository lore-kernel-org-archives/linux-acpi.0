From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Frequency scaling, Dell Inspiron 6000
Date: Mon, 30 Jul 2007 20:00:32 +0100
Message-ID: <20070730190032.GA7328@srcf.ucam.org>
References: <46AC9E33.3020008@molgaard.org> <20070730004423.GA27398@srcf.ucam.org> <46ADE700.6070400@molgaard.org> <20070730180111.GA6881@srcf.ucam.org> <46AE2B76.5070303@molgaard.org> <20070730182214.GA7285@srcf.ucam.org> <46AE2EB2.80509@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-32-9-130.no-dns-yet.enta.net ([78.32.9.130]:57362 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S966864AbXG3TAp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jul 2007 15:00:45 -0400
Content-Disposition: inline
In-Reply-To: <46AE2EB2.80509@molgaard.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sune =?iso-8859-1?Q?M=F8lgaard?= <sune@molgaard.org>
Cc: linux-acpi@vger.kernel.org

On Mon, Jul 30, 2007 at 08:32:18PM +0200, Sune M=F8lgaard wrote:

> Ok, so in order to utilize p4-clockmod and get a lower temperature =3D=
>
> lower fan noise, do I just load the module? Or what more do I do?

Yes, and make sure that /devices/system/cpu/*/cpufreq/scaling_governor=20
is set to ondemand or conservative.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
