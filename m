From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Bug #13471] Loading parport_pc kills the keyboard if ACPI is
 enabled
Date: Fri, 31 Jul 2009 16:17:35 +0100
Message-ID: <20090731161735.6a94ad9c@lxorguk.ukuu.org.uk>
References: <DizPU9GBfHF.A.kgF.iWObKB@chimera>
	<H5-1lZIIeYK.A.dWH.9XObKB@chimera>
	<20090731151417.568094e5@lxorguk.ukuu.org.uk>
	<4A7308E8.1000200@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57543 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751621AbZGaPQ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 11:16:59 -0400
In-Reply-To: <4A7308E8.1000200@pardus.org.tr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ozan =?UTF-8?B?w4dhxJ9sYXlhbg==?= <ozan@pardus.org.tr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

O> Finally, it seems that the problem is available with 2.6.28, so the starting
> point is still fuzzy to me. I remember that the keyboard was working OK with
> 2.6.29_rc7 but now it's not.
> 
> Maybe we should drop this report from the regression list."
> 
> 
> Monday I'll have access to the computer. I'll build and try to find the last working version.
> Meanwhile, I'd like to hear about your possible finding.

There have been few changes to parport_pc but one thing recent changed
the probe for SuperIO chips via low addresses and that could be
interfering.

commit e2434dc1c19412639dd047a4d4eff8ed0e5d0d50
Author: Jens Rottmann <JRottmann@LiPPERTEmbedded.de>
Date:   Mon Jun 22 16:51:49 2009 +0100

changed the behaviour slightly (hence asking about which release if it
was a recent breakage). Its also a code area with very few changes so if
you can find which one worked last, you should be able to transplant that
parport_pc into 2.6.current and see if its parport or acpi triggered
breakage.

Alan
