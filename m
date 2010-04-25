From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Sat, 24 Apr 2010 19:08:29 -0500
Message-ID: <1272154109.1839.345.camel@laptop>
References: <1272062884.1594.73.camel@laptop>
	 <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop>
	 <20100424211601.GA16731@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37778 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab0DYAIg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Apr 2010 20:08:36 -0400
In-Reply-To: <20100424211601.GA16731@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On Sat, 2010-04-24 at 22:16 +0100, Matthew Garrett wrote:
> On Sat, Apr 24, 2010 at 03:49:38PM -0500, Jerone Young wrote:
> 
> > The issue is the way Windows does it is through a userspace daemon.  By
> > making it OSI=Linux (just as with the Thinkpads currently already in
> > blacklist.c ..*61 line) the machines just send the OS a key press.
> 
> And how does that userspace daemon receive the event?

Well it's a daemon and a suite. Don't know if you have ever seen a
Thinkpad with Windows? .. but has a lot of Think tools & such. Apart of
these tools is an OSD as well.

What I gather (could be wrong). It waits for some bit to change in th EC
indicating the mute has been changed. Then it alerts Windows that an the
event happens and changes things at that Level (maybe by sending a mute
key press??) .. but at the Windows userspace Level things get muted and
unmuted properly. In turn muting both speakers & headphones.


				Jerone

> > Since newer thinkpads as well as most other OEM machines take this
> > model. It provides a much better user experience then what it is like
> > today.
> 
> It's a model-specific quirk in generic code, so it's massively desirable 
> to avoid this especially since it encourages other OEMs to do the same 
> kind of thing.

As mentioned in the first email, Lenovo has stopped doing this with the
newly release Thinkpads (ex. X201 & T410). By blacklisting these they
act the same as newer Thinkpads.


> 


