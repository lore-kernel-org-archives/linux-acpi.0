From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH 0/2]: the patch set to weaken the dependency between
	ACPI video driver and i915 driver
Date: Thu, 16 Apr 2009 09:15:31 +0800
Message-ID: <1239844531.3638.14.camel@localhost.localdomain>
References: <1239678275.5564.66.camel@localhost.localdomain>
	 <20090414193538.GB8304@srcf.ucam.org>
	 <1239757961.5564.109.camel@localhost.localdomain>
	 <20090415045359.GA15437@srcf.ucam.org>
	 <9F0C1DB20AFA954FA1DA05309350433D5B2E7517@pdsmsx503.ccr.corp.intel.com>
	 <20090415165409.GB27807@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4575 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbZDPBOX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Apr 2009 21:14:23 -0400
In-Reply-To: <20090415165409.GB27807@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-04-16 at 00:54 +0800, Matthew Garrett wrote:
> Sorry, I should have been clearer. ACPI is required if the hardware 
> supports opregion. Now that I've thought about it more, I think the 
> patch I've just sent should remove the need to change the #ifdefs in
> the 
> video driver
Agree.    If another patch from you is applied, it is unnecessary to
change the #ifdef in the acpi video driver.
    Please go ahead. Thanks.

Another issue is about the ACPI opregion. For the boxes that supports
ACPI opregion the brightness still can't be controlled even when the
acpi video driver is loaded correctly. Only after the i915 driver is
loaded, the ACPI backlight I/F can work well. In such case whether the
ACPI video driver can work well depends on the i915 driver.
    But whether the i915 driver can work well doesn't depend on the acpi
video driver. Right? 

At the same time a lot of people complain fail in the kernel compilation
if the i915 is compiled as builtin module and acpi video is compiled as
module. 

So we had better make some changes so that there is no failure about
kernel compilation.

thanks.




