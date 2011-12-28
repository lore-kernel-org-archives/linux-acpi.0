From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Broken suspend to RAM on Asus P8P67-M motherboard (bad BIOS?)
Date: Thu, 29 Dec 2011 00:55:04 +0100
Message-ID: <201112290055.04384.rjw@sisk.pl>
References: <20111228231919.GI8711@bender.csupomona.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42913 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679Ab1L1Xvv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Dec 2011 18:51:51 -0500
In-Reply-To: <20111228231919.GI8711@bender.csupomona.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Paul B. Henson" <henson@acm.org>
Cc: linux-kernel@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi,

On Thursday, December 29, 2011, Paul B. Henson wrote:
> I have an Asus P8P67-M Pro motherboard which fails to suspend to ram
> under Linux yet suspends successfully under Windows 7.
> 
> Under Windows 7, suspending results in the typical slowly blinking
> power light, and the system wakes up correctly.
> 
> Under Linux (tested with 3.0.7 and 3.1.6), on entering suspend mode the
> power light turns off and stays off, it does *not* blink. On attempting
> to wake up, the power light turns on momentarily and the fans spin up,
> the power light goes off again and the fans spin down, then the power
> light/fans come on but nothing happens, the box is completely wedged,
> not even the reset button works, requiring a hard power cycle to bring
> back.

You may try to pass acpi_sleep=nonvs or acpi_sleep=sci_force_enable to
the kernel command line and retest.

> While working on the issue, I noticed the following suspicious ACPI
> errors logged when doing a core test of STR:
> 
> Dec 28 14:28:41 htpc-lr kernel: ACPI: Preparing to enter system sleep
> state S3
> Dec 28 14:28:41 htpc-lr kernel: ACPI Error: [RAMB] Namespace lookup
> failure, AE_NOT_FOUND (20110623/psargs-359)
> Dec 28 14:28:41 htpc-lr kernel: ACPI Error: Method parse/execution
> failed [\_PTS] (Node ffff88011e8a3a38), AE_NOT_FOUND
> (20110623/psparse-536)

Well, please attach the output of acpidump from your system.

> There is also an ACPI complaint during boot:
> 
> ACPI Error: [RAMB] Namespace lookup failure, AE_NOT_FOUND
> (20110623/psargs-359)
> ACPI Exception: AE_NOT_FOUND, Could not execute arguments for [RAMW]
> (Region) (20110623/nsinit-349)
> 
> The core test worked fine with no issues. I'm pretty sure the root cause
> of the problem is that the system is not correctly entering S3 due to
> these ACPI issues (given the lack of the usual blinking power light).
> I'm guessing there's something broken in the BIOS and have opened a
> support request with Asus.
> 
> However, given it "works under Windows (tm)" 8-/, I don't anticipate a timely
> response from Asus <sigh>.
> 
> Clearly Windows is working around whatever BIOS problem exists. If it's
> not too ugly or distasteful, it would be nice if Linux could do so as
> well, I hate it when Windows seems more robust ;).

Well, the problem is we need to know what to do, which may be difficult
(if not impossible) to figure out without the (already missing) vendor
information.

Thanks,
Rafael
