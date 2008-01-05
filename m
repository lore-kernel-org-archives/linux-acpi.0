From: devzero@web.de
Subject: always 3 times: "AE_NOT_FOUND, Processor Device is not present"
Date: Sat, 05 Jan 2008 13:22:43 +0100
Message-ID: <87396499@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate05.web.de ([217.72.192.243]:57067 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbYAEMWp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 07:22:45 -0500
Received: from web.de
	by fmmailgate05.web.de (Postfix) with SMTP id 5AE313A82711
	for <linux-acpi@vger.kernel.org>; Sat,  5 Jan 2008 13:22:44 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

came across this by some module testing and i`m just curious why that m=
essage is always being printed 3 times where one would be enough.

indeed a very minor issue (if any) - just wanted to let you know....


modprobe acpi-cpufreq

 ACPI: Processor [CPU0] (supports 8 throttling states)
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
----------------------------------------------------------------
modprobe powernow-k7

 ACPI: Processor [CPU0] (supports 8 throttling states)
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 powernow: This module only works with AMD K7 CPUs
----------------------------------------------------------------
modprobe powernow-k8

 ACPI: Processor [CPU0] (supports 8 throttling states)
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
----------------------------------------------------------------
modprobe processor

 ACPI: Processor [CPU0] (supports 8 throttling states)
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
----------------------------------------------------------------
modprobe thermal

 ACPI: Processor [CPU0] (supports 8 throttling states)
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]
 ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device i=
s not present [20070126]

_______________________________________________________________________
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=3D0222=
20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
