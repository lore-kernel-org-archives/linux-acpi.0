From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/6] [resend] thermal: improvements re. forced passive
 cooling
Date: Thu, 05 Nov 2009 18:26:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911051819180.19209@localhost.localdomain>
References: <1256542744-26569-1-git-send-email-elendil@planet.nl>
 <20091028153551.6c665ca1.akpm@linux-foundation.org>
 <200910282349.06322.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:37082 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbZKEX1K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Nov 2009 18:27:10 -0500
In-reply-to: <200910282349.06322.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Sujith Thomas <sujith.thomas@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

> It turned out there was no bug in the kernel...
...
> It would have been nice if it had made .32 from my first submission,

Yeah, the discussion settled down just as the merge window openend,
and this isn't high risk, so in retrospect I should have pushed
it into 2.6.32.

> but now it's fine for .33. It's not stable material.

I'll push the documentation update to 2.6.32.

I'll push the tweaks to 2.6.33.
I don't expec that this will need to be back-ported
as only advanced users who also have this BIOS bug will be messing
around setting their own custom passive trip point in the first place.

thanks,
Len Brown, Intel Open Source Technology Center

