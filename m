From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: acpi on the sony tx1xp vaio laptop
Date: Thu, 19 Jan 2006 09:47:26 +0000
Message-ID: <20060119094726.GA24566@srcf.ucam.org>
References: <e1868cfe0601181717m47dbb220l92d2b70033ca4655@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:14014 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932580AbWASJrb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 04:47:31 -0500
Content-Disposition: inline
In-Reply-To: <e1868cfe0601181717m47dbb220l92d2b70033ca4655@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Minty <mintywalker@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, Jan 19, 2006 at 01:17:09AM +0000, Minty wrote:

> /proc/acpi/fan exists, but is empty.

That's pretty normal. Your fan is controlled by the BIOS, and not 
exposed via ACPI.

> By the by, I can suspend to RAM (although it takes between 60 and 120
> seconds to resume from that state), but suspend to disk is entirely
> broken.  I am assuming a switch to suspend2 should help there, which
> I'm hoping Kubuntu are going to adopt in a later release.  Although
> any pointers would be most welcome.

No, we're not planning on moving to suspend2.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
