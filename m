From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: ACPI-Problems with debian-etch & Kernel 2.6.16
Date: Tue, 28 Mar 2006 04:16:36 +0100
Message-ID: <E1FO4hA-0000e4-00@skye.ra.phy.cam.ac.uk>
References: <4426AD63.8080505@aol.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:22218 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751224AbWC1DQj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Mar 2006 22:16:39 -0500
In-Reply-To: Your message of "Sun, 26 Mar 2006 17:04:03 +0200."
             <4426AD63.8080505@aol.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joschka Sulzer <joschkasulzer@aol.com>
Cc: linux-acpi@vger.kernel.org

> These messages appear every 10 seconds!

Do you have thermal polling turned on?

more /proc/acpi/thermal_zone/*/polling_frequency

Not that you should turn the polling off, but maybe every time a
thermal poll is run, the embedded controller (ec) does an UPDT, which
also means it looks at the battery state.  And maybe the UPDT causes
the namespace AE_NOT_FOUND.  Perhaps it didn't cause a problem before
because the default used to be ec_intr=0, and the ec worked fine with
that setting.

You could try booting with ec_intr=0 to see if it suppresses the
problem.

I've spent a while (see bugzilla #5989) debugging the consequences of
changing the default from ec_intr=0 to ec_intr=1 (which happened in
2.6.16-rc* sometime -- see the #5989 bugzilla entries for the exact
git commit id).  Probably it's a good change in general -- I leave
that to the experts -- but it has certainly exposed a few troubles in
the mangy BIOS on my TP 600X.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
