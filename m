From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: DMI Info from Dell Latitude XT (and one weird ACPI issue)
Date: Sat, 18 Oct 2008 22:56:20 +0100
Message-ID: <20081018215620.GA18897@srcf.ucam.org>
References: <1224356565.5831.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49083 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYJRV4Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Oct 2008 17:56:25 -0400
Content-Disposition: inline
In-Reply-To: <1224356565.5831.14.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Milan Plzik <milan.plzik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, Oct 18, 2008 at 09:02:45PM +0200, Milan Plzik wrote:
> Oct 18 12:06:27 [kernel] [72428.864272] ACPI Error (psloop-0136): Found unknown opcode C0 at AML address ffffc200000267c7 offset 0, ignoring [20080609]
> Oct 18 12:06:27 [kernel] [72428.864280] ACPI Error (psloop-0136): Found unknown opcode ED at AML address ffffc200000267c8 offset 1, ignoring [20080609]
> Oct 18 12:06:27 [kernel] [72428.864286] ACPI Error (psloop-0136): Found unknown opcode 6F at AML address ffffc200000267c9 offset 2, ignoring [20080609]
> Oct 18 12:06:27 [kernel] [72428.864296] ACPI Error (psloop-0136): Found unknown opcode 4 at AML address ffffc200000267cc offset 5, ignoring [20080609]
> Oct 18 12:06:27 [kernel] [72428.864302] ACPI Error (psloop-0136): Found unknown opcode B0 at AML address ffffc200000267ce offset 7, ignoring [20080609]
> Oct 18 12:06:27 [kernel] [72428.864308] ACPI Error (psloop-0136): Found unknown opcode C3 at AML address ffffc200000267cf offset 8, ignoring [20080609]
> Oct 18 12:06:27 [kernel] [72428.864316] ACPI Error (psloop-0136): Found unknown opcode 6F at AML address ffffc200000267d9 offset 12, ignoring [20080609]

Yeah, we're seeing this on a few machines on resume - acpidump still 
gives the correct output, so it seems to be something to be some sort of 
internal state corruption. How much RAM do you have?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
