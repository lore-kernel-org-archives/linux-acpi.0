From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Tue, 15 Apr 2008 12:41:10 +0930 (CST)
Message-ID: <200804150311.m3F3BABd011256@turbo.physics.adelaide.edu.au>
References: <1208169984.1784.37.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:56611 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761870AbYDODjN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 23:39:13 -0400
In-Reply-To: <1208169984.1784.37.camel@queen.suse.de> from "Thomas Renninger" at Apr 14, 2008 12:46:24 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, nokos@gmx.net, linux-acpi@vger.kernel.org

Hi

> IMO there should be two fujitsu drivers, one for:
> ACPI_FUJITSUB1_HID                "FUJ02B1"
> e.g. acpi_fujitsu_brightness
> or
> acpi_fujitsu_02b1
> and one for:
> ACPI_FUJITSUE3_HID                "FUJ02E3"
> e.g. acpi_fujitsu_keys
> or
> acpi_fujitsu_02e3
> not sure what the perfect name could be...
> 
> There probably are machines out there which only have one of above
> devices, then only the relevant driver should be loaded.

I tend to agree with the idea of separate drivers since circumstantial
evidence suggests that Fujitsu do change the roles of these components
between models.  It think it would be entirely possible that some laptops
have only one of these device functions.  Given this, the modular approach
would seem to be more maintainable going forward.  I haven't however looked
into this in any detail.

As for names, "acpi_fujitsu_brightness", "acpi_fujitsu_keys" makes sense but
are perhaps a little long.  Going with just "fujitsu_brightness" and
"fujitsu_keys" isn't really any less clear unless of course the respective
devices end up controlling things other than those already identified.  To
stay completely generic, "fujitsu_02b1" and "fujitsu_02e3" would be best
although clearly these don't suggest any idea of their functionality.

> You should also take people into CC who are already stated as authors in
> the driver, chances are high that they miss this post.

Thanks for raising this.  I did indeed miss it. :-)

> Someone should review this who is deeper involved into fujitsu machines.

I wouldn't say I'm deepling involved in the fujitsu machines or all that
knowledgeable about ACPI, but I do have an S7020 which is what the
fujitsu-laptop module was developed on. :-)

Regards
  jonathan
