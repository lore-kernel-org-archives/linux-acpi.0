From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: 64-bit DMA problems with BCM4312 using b43
Date: Fri, 13 Nov 2009 21:40:53 -0600
Message-ID: <4AFE26C5.5080402@lwfinger.net>
References: <4AFD958E.1000303@lwfinger.net> <20091113201112.GA5540@srcf.ucam.org> <200911132144.24110.mb@bu3sch.de> <4AFDCA0E.4080007@lwfinger.net> <20091113211306.GA6600@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:59899 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755465AbZKNDku (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2009 22:40:50 -0500
In-Reply-To: <20091113211306.GA6600@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Michael Buesch <mb@bu3sch.de>, bcm43xx-dev@lists.berlios.de, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 11/13/2009 03:13 PM, Matthew Garrett wrote:
> On Fri, Nov 13, 2009 at 03:05:18PM -0600, Larry Finger wrote:
> 
>> I'm in the process of creating a patch to set the latency to 200 usec. The
>> default is 2000. On my fast prosessors, it should not be anything nearly that
>> slow. If we determine this to be the problem, then we can try tuning.
> 
> The latency is the amount of time it takes to get out of deep C states 
> and into C0. That's a function of the processor design rather than the 
> frequency.

Thanks for your suggestion. The value of 200 fixed one of the two machines and
greatly improved the other. He is currently testing with a value of 150, and
will try 100 if that still fails.

Larry


