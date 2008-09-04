From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [RESEND] [PATCH] fujitsu-laptop: fix regression for P8010 in
 2.6.27-rc
Date: Thu, 04 Sep 2008 14:25:50 +0200
Message-ID: <48BFD3CE.8050602@linux.intel.com>
References: <200808290136.m7T1aMKV021585@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:35307 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751584AbYIDMZr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 08:25:47 -0400
In-Reply-To: <200808290136.m7T1aMKV021585@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org

Jonathan Woithe wrote:
> Hi Andi
> 
> The following patch (based on a patch from Stephen Gildea) fixes a
> regression with the LCD brightness keys on Fujitsu P8010 laptops which was
> observed with the 2.6.27-rc series (basically they stopped working due to
> changes within the fujitsu-laptop and video modules).  Please apply to
> 2.6.27-rc and acpi git.
> 
> A more complete solution for this laptop will be included in an upcoming
> patch, hopefully for 2.6.28.  In the meantime this restores most
> functionality for P8010 users.

Added thanks

-Andi
