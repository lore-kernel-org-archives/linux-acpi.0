From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Sun, 13 Jul 2008 13:02:53 +0100
Message-ID: <20080713120253.GA27582@srcf.ucam.org>
References: <200807010148.02135.rjw@sisk.pl> <200807122253.32382.rjw@sisk.pl> <48793A0E.3050803@myrealbox.com> <200807130133.12324.rjw@sisk.pl> <20080713091524.GA29907@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50635 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbYGMMDi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jul 2008 08:03:38 -0400
Content-Disposition: inline
In-Reply-To: <20080713091524.GA29907@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andy Lutomirski <luto@myrealbox.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

On Sun, Jul 13, 2008 at 11:15:24AM +0200, Ingo Molnar wrote:

> we still need to find the HAL quirk and disable it, right?

Not without understanding what the cause is. If the video BIOS calls are 
generically broken, then we have a problem.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
