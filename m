From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Re: Frequency scaling, Dell Inspiron 6000
Date: Mon, 30 Jul 2007 21:40:17 +0200
Message-ID: <46AE3EA1.9020704@molgaard.org>
References: <46AC9E33.3020008@molgaard.org> <20070730004423.GA27398@srcf.ucam.org> <46ADE700.6070400@molgaard.org> <20070730180111.GA6881@srcf.ucam.org> <46AE2B76.5070303@molgaard.org> <20070730182214.GA7285@srcf.ucam.org> <46AE2EB2.80509@molgaard.org> <20070730190032.GA7328@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cicero0.cybercity.dk ([212.242.40.52]:58690 "EHLO
	cicero0.cybercity.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763361AbXG3Tk2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jul 2007 15:40:28 -0400
In-Reply-To: <20070730190032.GA7328@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Mon, Jul 30, 2007 at 08:32:18PM +0200, Sune M=F8lgaard wrote:
>=20
>> Ok, so in order to utilize p4-clockmod and get a lower temperature =3D=
>
>> lower fan noise, do I just load the module? Or what more do I do?
>=20
> Yes, and make sure that /devices/system/cpu/*/cpufreq/scaling_governo=
r=20
> is set to ondemand or conservative.
>=20

Ok, thank you. That seems to work :-)

Best regards,

Sune

--=20
I really didn't foresee the Internet. But then, neither did the compute=
r=20
industry. Not that that tells us very much of course - the computer=20
industry didn't even foresee that the century was going to end.
- Douglas Adams
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
