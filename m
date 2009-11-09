From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Mon, 9 Nov 2009 16:54:20 +0000
Message-ID: <20091109165420.GA28672@srcf.ucam.org>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54786 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbZKIQy0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 11:54:26 -0500
Content-Disposition: inline
In-Reply-To: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Nov 09, 2009 at 11:47:30AM -0500, Andrew Lutomirski wrote:
> The ThinkPad X200s, like the X61, requires OSI=Linux for the mute
> button to work.  Without this patch (or the equivalent command-line
> parameter), the mute button does not generate a keystroke and,
> instead, messes up the sound hardware.

No. How does this work on Windows? Note that we *have* a special driver 
for Thinkpads, and it's entirely acceptable to require it in order to 
have sensible behaviour. We do not want to encourage vendors to 
special-case Linux.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
