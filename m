From: Pavel Troller <patrol@sinus.cz>
Subject: ACPI error during boot - does it need fixing ?
Date: Sun, 20 Dec 2009 08:02:24 +0100
Message-ID: <20091220070223.GA8334@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([89.250.251.168]:58158 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbZLTHRg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Dec 2009 02:17:36 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.14.1/8.14.1) with ESMTP id nBK72OY2008724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sun, 20 Dec 2009 08:02:24 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.14.1/8.14.1/Submit) id nBK72OkU008723
	for linux-acpi@vger.kernel.org; Sun, 20 Dec 2009 08:02:24 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
  On my new system with Gigabyte G41M-ES2H mobo and Intel Core Quad Q8300 CPU,
there are the following errors reported on boot:

ACPI: SSDT 00000000cdcedb10 0022A (v01  PmRef  Cpu0Ist 00003000 INTL 20040311)
Marking TSC unstable due to TSC halts in idle
Switching to clocksource hpet
processor LNXCPU:00: registered as cooling_device0
ACPI: SSDT 00000000cdcedfd0 00152 (v01  PmRef  Cpu1Ist 00003000 INTL 20040311)
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] (Node ffff88012f815a00), AE_ALREADY_EXISTS
ACPI: Marking method _PDC as Serialized because of AE_ALREADY_EXISTS error
processor LNXCPU:01: registered as cooling_device1
ACPI: SSDT 00000000cdcee130 00152 (v01  PmRef  Cpu2Ist 00003000 INTL 20040311)
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] (Node ffff88012f815a80), AE_ALREADY_EXISTS
ACPI: Marking method _PDC as Serialized because of AE_ALREADY_EXISTS error
processor LNXCPU:02: registered as cooling_device2
ACPI: SSDT 00000000cdcee290 00152 (v01  PmRef  Cpu3Ist 00003000 INTL 20040311)
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU3._PDC] (Node ffff88012f815b00), AE_ALREADY_EXISTS
ACPI: Marking method _PDC as Serialized because of AE_ALREADY_EXISTS error
processor LNXCPU:03: registered as cooling_device3

  Is this error just cosmetic, or is it worth fixing ? There is no BIOS update
for this motherboard yet. Are the SSDT tables replaceable the same way as DSDT
is ? 

  With regards, Pavel
