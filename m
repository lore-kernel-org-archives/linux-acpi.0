From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Sun, 13 Jul 2008 20:02:47 +0200
Message-ID: <200807132002.48330.rjw@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <20080713091524.GA29907@elte.hu> <20080713120253.GA27582@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:39230 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310AbYGMSA6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Jul 2008 14:00:58 -0400
In-Reply-To: <20080713120253.GA27582@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andy Lutomirski <luto@myrealbox.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

On Sunday, 13 of July 2008, Matthew Garrett wrote:
> On Sun, Jul 13, 2008 at 11:15:24AM +0200, Ingo Molnar wrote:
> 
> > we still need to find the HAL quirk and disable it, right?
> 
> Not without understanding what the cause is. If the video BIOS calls are 
> generically broken, then we have a problem.

To check that, we need a system which is confirmed to need acpi_sleep=s3_bios
to resume without commit 4b4f7280.

Unfortunately, I don't have any systems like this.

Thanks,
Rafael
