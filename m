From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Avoid critical temp shutdowns on specific ThinkPad T4x(p) and
 R50p
Date: Tue, 12 Aug 2008 10:00:26 +0200
Message-ID: <48A1431A.8090300@linux.intel.com>
References: <200807301556.01815.trenn@suse.de> <200808111433.25275.trenn@suse.de> <20080811125519.GA26308@srcf.ucam.org> <200808111614.17161.trenn@suse.de> <20080811141552.GA28294@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:60375 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670AbYHLIAY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Aug 2008 04:00:24 -0400
In-Reply-To: <20080811141552.GA28294@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Matthew Garrett wrote:
> On Mon, Aug 11, 2008 at 04:14:14PM +0200, Thomas Renninger wrote:
> 
>> So what is the status here, how should we proceed?
>> This isn't applied to any tree yet?
>> IMO you should send those two with below fixed and Andi could queue them on 
>> the test branch and keep it a while there.
> 
> I posted them, got a small amount of feedback and no further acks. I can 
> push them again.

The problem seems to be that some people report this as a regression.
So either:

- It's not actually an regression but has always been this way.
In this case it's fine to delay.

- It's an regression. Then something must have been changed. Do we know what that is?
If it's really an regression then we need a low-risk fix for .27.

-Andi


