From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Mon, 9 Nov 2009 17:54:16 +0000
Message-ID: <20091109175416.GA29887@srcf.ucam.org>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com> <20091109165420.GA28672@srcf.ucam.org> <cb0375e10911090949o4a51cfd5x4f896d983398a7bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41003 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZKIRyU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 12:54:20 -0500
Content-Disposition: inline
In-Reply-To: <cb0375e10911090949o4a51cfd5x4f896d983398a7bc@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, ibm-acpi@hmh.eng.br

On Mon, Nov 09, 2009 at 12:49:56PM -0500, Andrew Lutomirski wrote:

> The Thinkpad mixer is really weird AFAICT.  I have no idea how the
> mute button works in Windows with the driver, but I'm not sure that it
> looks like a key press -- I think it does something to the mixer and
> the driver detects it.

When you hit the mixer button, does the ACPI interrupt count increase? 
If so, we're certainly in a position to do something with it.

> I actually think the "Linux" behavior makes more sense -- the volume
> up and down buttons already work on all operating systems, and with
> this patch the mute button works the same way.
>
> There's precedent for this hack, and regardless of what we want to
> convince Lenovo to do, making existing hardware work is nice:
> http://bugzilla.kernel.org/show_bug.cgi?id=9907

But it does nothing to solve the underlying issue, and then we get to 
apply the same patch again for the next Thinkpad product cycle. If we 
fix it properly, we don't need to bother.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
