From: Nephila <segnalazioni@nephila.it>
Subject: Cool & Quiet Phenom II X3
Date: Sun, 5 Apr 2009 18:01:45 +0200
Message-ID: <200904051801.46084.segnalazioni@liste.nephila.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cinghialix.iast.it ([62.48.49.32]:55409 "EHLO smtp.nephila.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbZDEQKo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Apr 2009 12:10:44 -0400
Received: from smtp.nephila.it (localhost [127.0.0.1])
	by smtp.nephila.it (Mail Daemon) with ESMTP id 2310F8062
	for <linux-acpi@vger.kernel.org>; Sun,  5 Apr 2009 18:01:47 +0200 (CEST)
Received: from sicuro.nephila.it (caiusbonus [192.168.200.28])
	by smtp.nephila.it (Mail Daemon) with ESMTP id 097D8809F
	for <linux-acpi@vger.kernel.org>; Sun,  5 Apr 2009 18:01:47 +0200 (CEST)
Received: from andalu.localnet (static-217-133-226-194.clienti.tiscali.it [217.133.226.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sicuro.nephila.it (Mail Daemon) with ESMTP id D8B688D6C
	for <linux-acpi@vger.kernel.org>; Sun,  5 Apr 2009 18:01:46 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, i just built a Phenomi II X3-based box and i got this error while loading 
powernow-k8 modules:

powernow-k8: ACPI Processor support is required for SMP systems but is absent. 
Please load the ACPI Processor module before starting this driver.

Needles to say CONFIG_ACPI_PROCESSOR is active (as module) and processor.ko is 
loaded before powernow-k8.ko

I'm aware of some BIOS-related problem with Cool&Quiet: is the message above 
caused by BIOS as well?
I tried with both debian lenny and sid kernel (2.6.26 and 2.6.29 based).
Motherboard (GA-MA790XT-UD4P) is updated with latest BIOS (F3 released on 
2009/03/12)

-- 

Regards

Nephila sas
PGP key block: http://www.nephila.it/pgp
