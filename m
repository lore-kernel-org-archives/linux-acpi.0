From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] X86: Solve Dell Latitudes do not reboot on x86_64 more
 generally
Date: Mon, 7 Nov 2011 13:59:24 +0000
Message-ID: <20111107135923.GA17060@srcf.ucam.org>
References: <4EB39139.3090709@suse.de>
 <1320453843-938-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41577 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab1KGN71 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2011 08:59:27 -0500
Content-Disposition: inline
In-Reply-To: <1320453843-938-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, stable@kernel.org

On Sat, Nov 05, 2011 at 01:44:03AM +0100, Thomas Renninger wrote:
> There are quite some reports that those do not reboot:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/833705
> ->E6520, E6220
> http://www.linux-club.de/viewtopic.php?f=29&t=114459&start=20
> ->E5520
> and some more already are blacklisted

It's a bug in the SMM code on these machines, and it goes away if you 
disable VT-D. Let's try to actually fix it rather than adding to the 
blacklist, otherwise we'll just end up with another batch of broken 
Dells later on.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
