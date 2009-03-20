From: Norbert Preining <preining@logic.at>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Fri, 20 Mar 2009 01:40:43 +0100
Message-ID: <20090320004043.GF19755@gamma.logic.tuwien.ac.at>
References: <20090319212123.GA24700@srcf.ucam.org> <20090319213428.GK29624@gamma.logic.tuwien.ac.at> <20090319214437.GB24898@srcf.ucam.org> <20090319221527.GA11001@gamma.logic.tuwien.ac.at> <20090320002827.GB19755@gamma.logic.tuwien.ac.at> <20090320003823.GA27600@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:56726 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZCTAkq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 20:40:46 -0400
Content-Disposition: inline
In-Reply-To: <20090320003823.GA27600@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Fr, 20 M=E4r 2009, Matthew Garrett wrote:
> As far as we can tell, the handling of the handover is consistent acr=
oss=20
> all dual-GPU nvidia laptops[1]. The right place for support to end up=
 is=20
> in the kernel component of the nouveau drivers.

Whatever the nouveau drivers are? You mean those based on the kernel
mode swching? Unfortunately that is far from prime time, and we need
power saving now.

I will take a look over the weekend maybe I can add a patch ontop of
yours that only does that, taken from the code in the special vaio-Z
sony-laptop module.

Best wishes

Norbert

-----------------------------------------------------------------------=
--------
Dr. Norbert Preining <preining@logic.at>        Vienna University of Te=
chnology
Debian Developer <preining@debian.org>                         Debian T=
eX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 0=
9C5 B094
-----------------------------------------------------------------------=
--------
BODMIN
The irrational and inevitable discrepancy between the amount pooled
and the amount needed when a large group of people try to pay a bill
together after a meal.
			--- Douglas Adams, The Meaning of Liff
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
