From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Add BL power, LED control and
Date: Mon, 5 Jan 2009 09:10:49 +1030 (CST)
Message-ID: <200901042240.n04Men6J022263@mercury.physics.adelaide.edu.au>
References: <49611F97.6020601@linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:48282 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496AbZADWlo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Jan 2009 17:41:44 -0500
In-Reply-To: <49611F97.6020601@linx.net> from "Tony Vroon" at Jan 04, 2009 08:44:07 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony@linx.net
Cc: nokos@gmx.net, Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Hi Tony

> nokos@gmx.net wrote:
> > with ACPI_VIDEO:
> > both alt and std interface works (SBLL/SBL2), but only while X is
> > running (I think with ACPI_VIDEO all brighness change etc is handled by
> > the IGD stuff in i915 which is only active if X is running)
> 
> Okay, perhaps kernel mode setting will improve this situation. As
> userland isn't ready for KMS now I will back off on this and bring it up
> again at around the 2.6.30/2.6.31 timeframe. (As I do agree things
> should work correctly without X running)

Indeed.  Until use_alt is not required for any machine state it should not
be removed since the removal will constitute a functional regression.

> A simplier way to autodetect (taking into account your next mail about
> BLNF) would then be to see whether SBL2 exists, and use if it does.
> (I've checked all other DSDTs that I have, SBL2 is unique to the S64XX
> series).

That makes sense.

> My ultimate goal in this is to make the DMI-based recognition of
> machines unnecessary, especially if BTNI turns out to be useful in
> knowing the keymap.

Removing the need for DMI-based machine identification would be a good
thing as it's one less thing to maintain going forward.

Regards
  jonathan
