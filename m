From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Thu, 26 Nov 2009 05:07:48 +0000
Message-ID: <20091126050748.GA7874@srcf.ucam.org>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com> <alpine.LFD.2.00.0911242347030.4058@localhost.localdomain> <1259170225.4391.4.camel@laptop> <alpine.LFD.2.00.0911251317480.3950@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52942 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbZKZFH4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2009 00:07:56 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911251317480.3950@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jerone Young <jerone.young@canonical.com>, Andrew Lutomirski <luto@mit.edu>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Nov 25, 2009 at 01:24:50PM -0500, Len Brown wrote:

> Have these been verified as necessary to make sound work on
> the specified models, or are these speculative patches?

To clarify - these patches do *nothing* to make sound work. They change 
the behaviour of the mute key from changing the hardware state of the 
mixer and not sending a key event to instead sending a key event and 
requring that software perform the change. The behavioural change is 
primarily cosmetic rather than functional. I'm not convinced that this 
is a sensible thing to do at this point in the release cycle, given that 
we have no testing of what other behavioural changes the firmware may 
make.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
