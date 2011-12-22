From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ACPI failures on Dell Latitude E6220
Date: Thu, 22 Dec 2011 04:08:49 -0600
Message-ID: <20111222100849.GA6548@elie.Belkin>
References: <87r50zzvf6.fsf@pirx.pps.jussieu.fr>
 <87vcp998us.fsf@pirx.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45160 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab1LVKI6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2011 05:08:58 -0500
Received: by iaeh11 with SMTP id h11so13297057iae.19
        for <linux-acpi@vger.kernel.org>; Thu, 22 Dec 2011 02:08:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87vcp998us.fsf@pirx.pps.jussieu.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juliusz Chroboczek <jch@pps.jussieu.fr>
Cc: linux-acpi@vger.kernel.org

Juliusz Chroboczek wrote:

>>> [  227.525937] ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl] (20110623/evregion-478)
>>> [  227.525946] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1] (Node ffff880128e7a3d0), AE_TIME (20110623/psparse-536)
>>> [  227.525957] ACPI Error: Method parse/execution failed [\ECRB] (Node ffff880128e7a268), AE_TIME (20110623/psparse-536)
>
> This appears to be fixed, or at least worked around, by Debian's kernel
> 3.1.5-1.  My idle battery time doubled (yay!).  Turbostat indicates that
> the CPU is now entering the higher-numbered "PC" states, which it wasn't
> doing beforehand.

Thanks for the update.  Am I right in guessing that 3.1.4-1 is broken,
too, and that with 3.1.5-1 the ACPI exceptions are gone?  Could you
attach "dmesg" output from booting a fixed kernel for reference?

>From a quick glance, none of the fixes introduced by 3.1.5-1 seems to
explain this change in an obvious way.  Glad to hear the new kernel is
working well, though.

Curious,
Jonathan
