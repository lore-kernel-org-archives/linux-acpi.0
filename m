From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [lm-sensors] Patch[2/2] Adding Interrupt Handling Support to
 Coretemp
Date: Wed, 8 Dec 2010 22:16:45 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF04654105C0E06161@bgsmsx502.gar.corp.intel.com>
References: <D6D887BA8C9DFF48B5233887EF04654105C0E05F61@bgsmsx502.gar.corp.intel.com>
 <20101208150650.GA28273@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26307 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184Ab0LHQqt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Dec 2010 11:46:49 -0500
In-Reply-To: <20101208150650.GA28273@ericsson.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

> > From: Durgadoss R <durgadoss.r@intel.com>
> >
> > Date: Tue, 7 Dec 2010 04:10:41 +0530
> > Subject: [PATCH 2/2] Adding_Threshold_Interrupt_Handling_to_Coretemp
> >
> > This patch adds the interrupt handling for the core/package
> > thermal thresholds in coretemp. The interrupts are routed to coretemp
> > via therm_throt.c. Whenever an interrupt occurs, a notification is sent
> > in the form of a netlink event to the user space.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> >
> After browsing through this and the previous patch, I think the functionality
> should reside outside and be independent of hwmon. arch/x86/kernel/cpu or
> drivers/platform/x86 might be better places for it, though I am not really
> in a position to make that judgement.

I added the threshold support to hwmon because the existing coretemp
driver provided a nice infrastructure for this. For eg: I do not
have to create functions for reading current temperature, detecting
the CPU model, checking the DTS support etc..

But If you are saying that, the coretemp driver itself(not just
the threshold functionality), should be in a different location,
then, as you said, I am also not in a position to make the judgement.

Thanks,
Durgadoss
