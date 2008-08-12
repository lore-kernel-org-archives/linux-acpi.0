From: Andi Kleen <ak@linux.intel.com>
Subject: Re: Avoid critical temp shutdowns on specific ThinkPad T4x(p) and
 R50p
Date: Tue, 12 Aug 2008 11:32:16 +0200
Message-ID: <48A158A0.2080803@linux.intel.com>
References: <200807301556.01815.trenn@suse.de>	 <200808111433.25275.trenn@suse.de> <20080811125519.GA26308@srcf.ucam.org>	 <200808111614.17161.trenn@suse.de> <20080811141552.GA28294@srcf.ucam.org>	 <48A1431A.8090300@linux.intel.com> <1218529217.3209.9.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46245 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbYHLJcM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Aug 2008 05:32:12 -0400
In-Reply-To: <1218529217.3209.9.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net


> No, the problem we discussed here is not a regression.
> http://bugzilla.kernel.org/show_bug.cgi?id=10658
> And the patch just works for the laptops that:
> 1. without passive trip point
> 2. with a passive trip point that doesn't help because it is too close
> to the critical trip point.

Ok.

> And it's true that there is a thermal regression reported recently,
> http://bugzilla.kernel.org/show_bug.cgi?id=11281
> but IMO, that's another problem and we have not root caused yet.

I was indeed thinking of that one. Probably I confused it with this one.
Thanks for the clarification.

The problem is that all the people who complained about the later
regression didn't reply to my request for more information :/
Need to somehow move forward on that one.

-Andi
