From: Mattia Dongili <malattia@linux.it>
Subject: Re: ACPI vs. hibernate on MacBook5,1
Date: Wed, 15 Apr 2009 22:56:20 +0900
Message-ID: <20090415135620.GB12481@kamineko.org>
References: <1239802480.9071.14.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48649
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbZDON4Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 09:56:24 -0400
Content-Disposition: inline
In-Reply-To: <1239802480.9071.14.camel@johannes.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, Apr 15, 2009 at 03:34:39PM +0200, Johannes Berg wrote:
> Recently, since I upgraded to -rc1, I've been seeing this at hibernate:
> 
> [13875.384603] ACPI: Preparing to enter system sleep state S4
> [13875.385232] ACPI Error (hwvalid-0186): Denied AML access to port 0x0000000000000080/2 (DMA1 0x0081-0x0083) [20090320]
> [13875.385745] ACPI Exception (evregion-0422): AE_AML_ILLEGAL_ADDRESS, Returned by Handler for [SystemIO] [20090320]
> [13875.386244] ACPI Error (psparse-0537): Method parse/execution failed [\P8XH] (Node ffff88007e44ef70), AE_AML_ILLEGAL_ADDRESS
> [13875.386896] ACPI Error (psparse-0537): Method parse/execution failed [\_PTS] (Node ffff88007e44edd0), AE_AML_ILLEGAL_ADDRESS
> [13875.387584] PM: Saving platform NVS memory

there are patches for this here:
http://bugzilla.kernel.org/show_bug.cgi?id=13036
This should be the final one:
http://bugzilla.kernel.org/attachment.cgi?id=20913
Does it help?
-- 
mattia
:wq!
