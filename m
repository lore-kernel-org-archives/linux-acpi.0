From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] sony-laptop: support rfkill via ACPI interfaces
Date: Sat, 21 Mar 2009 23:45:21 +0900
Message-ID: <20090321144521.GA21615@kamineko.org>
References: <20090320003208.GC19755@gamma.logic.tuwien.ac.at> <20090320011837.GA23183@gamma.logic.tuwien.ac.at> <200903211222.36642.matze@welwarsky.de> <200903211453.49039.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:44844
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbZCUOpX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Mar 2009 10:45:23 -0400
Content-Disposition: inline
In-Reply-To: <200903211453.49039.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>
Cc: linux-acpi@vger.kernel.org

On Sat, Mar 21, 2009 at 02:53:48PM +0100, Matthias Welwarsky wrote:
> On Saturday 21 March 2009 12:22:35 Matthias Welwarsky wrote:
> > I've also backported Matthews patch to the standard Suse 11.1 kernel so
> > that we can test it more easily.
> 
> Done, looks quite promising. The "wireless" switch on the Z21 works now, and 
> apparently there is some script magic in opensuse that operates all rfkill 
> switches, so it kills all wireless devices at once. Not bad.
> 
> The new init sequence for SN07 also enables all the special keys, even the 
> speed/stamina switch now generates an ACPI event, as well as S1, S2 and Eject. 
> But you cannot distinguish them, they all report the same event.

You mey need the additional SN07 call to get the actual key press, see
the code in sony_acpi_notify.

-- 
mattia
:wq!
