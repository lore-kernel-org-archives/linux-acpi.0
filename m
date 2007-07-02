From: Norman Ziert <norman_ziert@web.de>
Subject: need support for MSI-9625 ACPI
Date: Mon, 02 Jul 2007 21:40:11 +0200
Message-ID: <4689549B.80301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:38847 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbXGBTkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jul 2007 15:40:20 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 27D6A8983A1A
	for <linux-acpi@vger.kernel.org>; Mon,  2 Jul 2007 21:40:19 +0200 (CEST)
Received: from [84.179.121.252] (helo=[192.168.2.3])
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.108 #197)
	id 1I5Rkq-0007Pg-00
	for linux-acpi@vger.kernel.org; Mon, 02 Jul 2007 21:40:12 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello folks,

I tried to korrekt the DSDT for the MSI-9625 board following some=20
tutorials I found, but it becomes worse than before.
So what information do you need to help me.

Symptoms of my problem are:
[1] no correct values in /proc/acpi/processors/CPU0/info (Pentium M 773=
 ULV)
[2] no changes in /proc/acpi/thermal_zone/THRM/temperature (permanently=
=20
40=B0C, is not true)
[3] could not load kernel module acpi_cpufreq (No such device,  <=20
schould be possible to load?)

I use Debian Etch on Pentium M 773 ULV, MSI 9625.


Norman
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
