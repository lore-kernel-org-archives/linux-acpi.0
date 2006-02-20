From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: Missing PSB or _PSS in BIOS
Date: Mon, 20 Feb 2006 12:00:51 +0100
Message-ID: <20060220110051.GA15047@poupinou.org>
References: <43F7CDA2.8030209@online.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:34593 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S964880AbWBTLAy
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Feb 2006 06:00:54 -0500
Content-Disposition: inline
In-Reply-To: <43F7CDA2.8030209@online.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vince <legoll@online.fr>
Cc: linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk

On Sun, Feb 19, 2006 at 02:45:06AM +0100, Vince wrote:
> Hello,
> 
> I'm using an opteron 165 (dual-core) which frequency/voltage should
> be able to be scaled, but unfortunately the latest BIOS for my motherboard
> lacks the frequency transition tables needed by powernow-k8.c
> 
> as shown by the boot message:
> powernow-k8: MP systems not supported by PSB BIOS structure
> powernow-k8:  BIOS error - no PSB or ACPI _PSS objects
> 
> Would it be possible to write suitable ACPI _PSS from AMD processor 
> documentation ?
> Or take the infos from some other ACPI BIOS which has support, and put 
> it in mine ?
> 
> And use the "ACPI load custom DSDT" kernel option to get the patched one 
> used by the
> powernow-k8 driver ?
> 
> I found a lot of infos about fixing glitches in DSDT but could not find 
> anything
> about adding missing  _PSS entries...
> 
> Would that be dangerous ?
> 
> Is there something else I could do ?
> I don't think I'll get an answer from the vendor, even if I tried...
> 

First, check if 'Cool'n Quiet' is enabled in the bios.  Second, if that
do not work, try to upgrade your bios.  I had a similar problem with a
HP Proliant 385, and after upgrading it was (almost) ok (they just
forgot one p-state, but it was easy to add it afterward).

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
