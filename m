From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Sat, 20 Dec 2008 21:08:26 +0000 (UTC)
Message-ID: <gijmsa$jsj$1@ger.gmane.org>
References: <gi247o$iog$1@ger.gmane.org> <20081215155655.GA1535@ucw.cz>
	<gi62fj$bnf$5@ger.gmane.org> <1229795024.9274.20.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38414 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbYLTVIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Dec 2008 16:08:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LE93r-0001dc-1S
	for linux-acpi@vger.kernel.org; Sat, 20 Dec 2008 21:08:35 +0000
Received: from d193-213-184.home3.cgocable.net ([67.193.213.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 20 Dec 2008 21:08:35 +0000
Received: from brian by d193-213-184.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 20 Dec 2008 21:08:35 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On Sat, 20 Dec 2008 17:43:44 +0000, Sergio Monteiro Basto wrote:
> 
> Well , I am thinking if you have a intel-video , and yes ! , I am
> getting in a same kind of trouble, I bet that is a problem with i915 drm
> , mesa 7.2 and xorg-x11-drv-intel (or i810) .

Not likely.  I unload all of that before I do my tests.  My tests are 
nothing more running that a shell (literally, that's the only process) 
and I have my module stack down to about half a dozen modules.

> Maybe you can try
> resume/suspend using vesa video drive, or without X.org running.

Not a solution.  See above.

b.


