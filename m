From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Illuminated keyboard on ASUS U50VG laptop, backlight or led ?
Date: Tue, 28 Jul 2009 21:04:49 +0100
Message-ID: <20090728200449.GA16330@srcf.ucam.org>
References: <71cd59b00907240034m5781fc4ciea2391d5fa17f85e@mail.gmail.com> <71cd59b00907281251k7fc6cf7fga433531572394b99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38204 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZG1UEx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2009 16:04:53 -0400
Content-Disposition: inline
In-Reply-To: <71cd59b00907281251k7fc6cf7fga433531572394b99@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, acpi4asus-user@lists.sourceforge.net

On Tue, Jul 28, 2009 at 09:51:09PM +0200, Corentin Chary wrote:

> No answers.
> I think I'll implement that as a backlight, because it is a backlight
> even if it's not for a screen.

I believe the SMC driver for the Apples does it via LED, so it might 
make sense to be consistent with that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
