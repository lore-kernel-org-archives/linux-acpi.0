From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Sat, 31 May 2008 21:25:50 +0100
Message-ID: <20080531202550.GA11409@srcf.ucam.org>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35731 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbYEaU0G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 31 May 2008 16:26:06 -0400
Content-Disposition: inline
In-Reply-To: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Trull <linmodemstudent@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, May 31, 2008 at 12:15:50PM -0700, Jeff Trull wrote:

> I'm running kernel 2.6.20 on a laptop with an ATI IGP 320M Northbridge
> and an Athlon XP.  DSDT has a _PTS but no _GTS.  I'm comfortable
> recompiling the kernel.  Any suggestions as to how to proceed,
> experiments to run, etc.?

I've seen something similar with an HP nc4010, which also had an ATI IGP 
northbridge. Sadly, I wasn't able to work out why this was happening. 
It wasn't possible to get at chipset docs at the time. Now that AMD are 
being more open about their graphics docs, I'll see if I can manage any 
more.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
