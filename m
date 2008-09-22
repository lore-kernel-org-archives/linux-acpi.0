From: Benjamin Scherrer <realhangman@web.de>
Subject: =?iso-8859-15?Q?MSI_K9A2_Platinum_Rev.1_bios_update_from_1.1_to_1.5_br?=
 =?iso-8859-15?Q?eaks_ACPI_=5FPSS_objects?=
Date: Mon, 22 Sep 2008 19:32:09 +0200
Message-ID: <1006443634@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate09.web.de ([217.72.192.184]:42525 "EHLO
	fmmailgate09.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbYIVRcM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 13:32:12 -0400
Received: from web.de
	by fmmailgate09.web.de (Postfix) with SMTP id BD0B72A59A2D
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2008 19:32:10 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I just updated my bios on the MSI K9A2 Platinum mainboard from version =
1.1 to 1.5. Unfortunately, cpufreq is not working any more, and "modpro=
be powernow-k8" gives me:

"powernow-k8: Found 1 AMD Phenom(tm) 9850 Quad-Core Processor processor=
s (4 cpu cores) (version 2.20.00)
powernow-k8: Your BIOS does not provide ACPI _PSS objects in a way that=
 Linux understands. Please report this to the Linux ACPI maintainers an=
d complain to your BIOS vendor."

I complaint to MSI, and am kindly asking you for advice what to do now,=
 since I don't want to run all my cpus on 100% all the time. Will the c=
pufreq_ondemand governer also work without the PSS objects?

greetings,
Benjamin

p.s. I mailed MSI that they should contact you at http://www.lesswatts.=
org/projects/acpi/ (just as info for you, they most probably won't do a=
nything I guess)

_______________________________________________________________________=
___
Verschicken Sie SMS direkt vom Postfach aus - in alle deutschen und vie=
le=20
ausl=E4ndische Netze zum gleichen Preis!=20
https://produkte.web.de/webde_sms/sms



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
