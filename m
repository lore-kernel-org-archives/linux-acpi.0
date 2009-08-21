From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Less strict requirements for video device detection
Date: Fri, 21 Aug 2009 09:17:38 +0800
Message-ID: <1250817458.17853.141.camel@rzhang-dt>
References: <4A8D140F.1090909@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:41305 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbZHUBT1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Aug 2009 21:19:27 -0400
In-Reply-To: <4A8D140F.1090909@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Thu, 2009-08-20 at 17:14 +0800, Stefan Bader wrote:
> Hardware: Acer 6920G (from a bug report)
> 
> Another case of a broken BIOS. In this case there are several definitions for 
> video bus devices but only one has _DOS and _DOD defined. All other definitions 
> only have _DOD.

I have seen such kind of BIOS too.

> In the past (2.6.27) _ADR was not evaluated to make sure of using a present 
> video device, but with that bug brightness could be changed.
> 
> Now the video bus having _DOS and _DOD is detected as not being present. The 
> other definitions are not considered because they are lacking the _DOS method.
> Using the attached patch, would cause the detection code to consider the other 
> definitions and has been tested to enable backlight control.
> 

> Would this be an acceptable approach?

I think so. I generated a similar patch before, but didn't sent it out
for some reason.
My suggestion is that we should also print out a warning message if _DOS
is missed, what do you think?

thanks,
rui

>  From the ACPI spec it rather sounds like 
> _DOD and _DOS must be present for a device for display switching and _DOS would 
> indicate possible backlight control as well. So the question might not be so 
> much is it the right thing than is it safe enough to allow more compatibility 
> with broken implementations without causing other problems...
> 
> -Stefan
> 

