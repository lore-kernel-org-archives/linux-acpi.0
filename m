From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 14:26:24 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063F9031@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:32137 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932494AbWCBT1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 14:27:20 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <ak@suse.de>

Dave,
Your DSDT looks fine.
I was wrong assuming there were 3 Processor entries there.

> > Did you really build a 256-CPU SMP kernel or is ACPI 
> > ignoring CONFIG_NR_CPUS or something?
>
>Yes, it's =256.

I expect this is the root problem.

-Len


