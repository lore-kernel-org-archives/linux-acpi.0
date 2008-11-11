From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI crash on lid close - SMP race?
Date: Tue, 11 Nov 2008 09:27:14 +0800
Message-ID: <1226366834.15014.60.camel@rzhang-dt>
References: <20081110161105.GA2041@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:38767 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbYKKB3y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Nov 2008 20:29:54 -0500
In-Reply-To: <20081110161105.GA2041@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

well, there is a bug report for this problem:
http://bugzilla.kernel.org/show_bug.cgi?id=11259

and there are some bug reports for a similar problem (system crashes on
lid close if _DOS=1, but on a UP platform).
http://bugzilla.kernel.org/show_bug.cgi?id=6001#c49

but unfortunately we haven't made any progress in this issue. :(

thanks,
rui

On Tue, 2008-11-11 at 00:11 +0800, Matthew Garrett wrote:
> If the _DOS flag on my HP 2510p is set to 0 (ie, signal OS when screen 
> notification is requested, don't change automatically) then it'll crash 
> on random lid open/closes. The trace generally makes little sense and 
> depends on the kernel version and phase of the moon. I'd ignored this as 
> firmware brokenness up until lately, but since having _DOS set to 0 is 
> the only way to get a notification when the display switch key is 
> pressed on this machine I'd be interested in fixing it properly. 
> 
> Unfortunately, I've got no real idea what on earth is going on. The only 
> clue I've found so far is that booting with maxcpus=1 leaves it working 
> perfectly. What parts of the ACPI stack could be triggering this?
> 

