From: Nephila <segnalazioni@nephila.it>
Subject: Re: Cool & Quiet Phenom II X3
Date: Thu, 16 Apr 2009 16:43:13 +0200
Message-ID: <200904161643.14216.segnalazioni@liste.nephila.it>
References: <200904051801.46084.segnalazioni@liste.nephila.it>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cinghialix.iast.it ([62.48.49.32]:60572 "EHLO smtp.nephila.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbZDPOnT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Apr 2009 10:43:19 -0400
In-Reply-To: <200904051801.46084.segnalazioni@liste.nephila.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Nephila <segnalazioni@nephila.it>, Thomas Renninger <trenn@suse.de>

Alle 18:01 di domenica 05 aprile 2009, Nephila ha scritto:
> Hi, i just built a Phenomi II X3-based box and i got this error while
> loading powernow-k8 modules:
>
> powernow-k8: ACPI Processor support is required for SMP systems but is
> absent. Please load the ACPI Processor module before starting this driver.
>
> Needles to say CONFIG_ACPI_PROCESSOR is active (as module) and processor.ko
> is loaded before powernow-k8.ko
>
> I'm aware of some BIOS-related problem with Cool&Quiet: is the message
> above caused by BIOS as well?
> I tried with both debian lenny and sid kernel (2.6.26 and 2.6.29 based).
> Motherboard (GA-MA790XT-UD4P) is updated with latest BIOS (F3 released on
> 2009/03/12)
Just for the record, during Easter holydays i had time to play a bit in the 
bios settings and after some bios reset to default all is fine now, so just 
discard my report
Thanks

-- 
Regards

Nephila sas
PGP key block: http://www.nephila.it/pgp
