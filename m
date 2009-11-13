From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 64-bit DMA problems with BCM4312 using b43
Date: Fri, 13 Nov 2009 21:13:06 +0000
Message-ID: <20091113211306.GA6600@srcf.ucam.org>
References: <4AFD958E.1000303@lwfinger.net> <20091113201112.GA5540@srcf.ucam.org> <200911132144.24110.mb@bu3sch.de> <4AFDCA0E.4080007@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37940 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbZKMVNI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2009 16:13:08 -0500
Content-Disposition: inline
In-Reply-To: <4AFDCA0E.4080007@lwfinger.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Michael Buesch <mb@bu3sch.de>, bcm43xx-dev@lists.berlios.de, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Nov 13, 2009 at 03:05:18PM -0600, Larry Finger wrote:

> I'm in the process of creating a patch to set the latency to 200 usec. The
> default is 2000. On my fast prosessors, it should not be anything nearly that
> slow. If we determine this to be the problem, then we can try tuning.

The latency is the amount of time it takes to get out of deep C states 
and into C0. That's a function of the processor design rather than the 
frequency.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
