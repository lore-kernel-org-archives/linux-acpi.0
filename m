From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
	them
Date: Sat, 24 Apr 2010 22:16:01 +0100
Message-ID: <20100424211601.GA16731@srcf.ucam.org>
References: <1272062884.1594.73.camel@laptop> <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54526 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab0DXVQG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Apr 2010 17:16:06 -0400
Content-Disposition: inline
In-Reply-To: <1272142178.1839.138.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: linux-acpi@vger.kernel.org

On Sat, Apr 24, 2010 at 03:49:38PM -0500, Jerone Young wrote:

> The issue is the way Windows does it is through a userspace daemon.  By
> making it OSI=Linux (just as with the Thinkpads currently already in
> blacklist.c ..*61 line) the machines just send the OS a key press.

And how does that userspace daemon receive the event?

> Since newer thinkpads as well as most other OEM machines take this
> model. It provides a much better user experience then what it is like
> today.

It's a model-specific quirk in generic code, so it's massively desirable 
to avoid this especially since it encourages other OEMs to do the same 
kind of thing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
