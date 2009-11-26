From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Thu, 26 Nov 2009 07:43:53 -0600
Message-ID: <1259243033.3153.1.camel@laptop>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	 <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain>
	 <1259170225.4391.4.camel@laptop>
	 <alpine.LFD.2.00.0911251317480.3950@localhost.localdomain>
	 <20091126050748.GA7874@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:41998 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbZKZNn5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2009 08:43:57 -0500
In-Reply-To: <20091126050748.GA7874@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Lutomirski <luto@mit.edu>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, 2009-11-26 at 05:07 +0000, Matthew Garrett wrote:
> On Wed, Nov 25, 2009 at 01:24:50PM -0500, Len Brown wrote:
> 
> > Have these been verified as necessary to make sound work on
> > the specified models, or are these speculative patches?
> 
> To clarify - these patches do *nothing* to make sound work. They change 
> the behaviour of the mute key from changing the hardware state of the 
> mixer and not sending a key event to instead sending a key event and 
> requring that software perform the change. 

It's more then cosmetic. On my X301 .. the headphone jack will not mute
without this if you do not have osi=Linux.

	
			Jerone

> The behavioural change is 
> primarily cosmetic rather than functional. I'm not convinced that this 
> is a sensible thing to do at this point in the release cycle, given that 
> we have no testing of what other behavioural changes the firmware may 
> make.
> 


