From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH RFT] fujitsu-laptop: Add BL power, LED control and radio state information
Date: Tue, 30 Dec 2008 10:09:13 +0000
Message-ID: <6C698870-C395-4DE4-B41D-6581EA2F7D5F@linx.net>
References: <200812300945.mBU9jAwh001915@mercury.physics.adelaide.edu.au>
Mime-Version: 1.0 (iPhone Mail 5F136)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:32905 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbYL3KI7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 05:08:59 -0500
In-Reply-To: <200812300945.mBU9jAwh001915@mercury.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Stephen Gildea <stepheng+linux@gildea.com>, Peter Gruber <nokos@gmx.net>, Julian Brown <jules@panic.cs-bristol.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

That is correct, aside from backlight power control no new  
functionality is unlocked on the S7020. Additional platform files  
should still appear, reporting a status of 'unknown'.
This should build successfully, with or without LED class support.

Sent from my iPhone

On 30 Dec 2008, at 09:45, Jonathan Woithe <jwoithe@physics.adelaide.edu.au 
 > wrote:

> Hi Tony
>
>> Jonathan, if this passes your testing please forward it on to Len  
>> Brown
>> ASAP for inclusion in 2.6.29 (the merge window is open so time is  
>> of the
>> essence).
>
> I will try.  I only returned from a 4-day camping trip today though,  
> which
> is why there was a delay in response.  Also the dialup connection at  
> home
> doesn't help.  I will endeavor to test this in the next day or so.   
> From
> what I gather, "testing" on the S7020 is more or less a case of  
> making sure
> that nothing's broken for me - as far as i can see this adds support  
> for
> things the S7020 doesn't have.
>
> Regards
>  jonathan
