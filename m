From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/6] acpi : move the acpi_idle_driver variable declaration
Date: Tue, 11 Sep 2012 22:28:47 +0200
Message-ID: <201209112228.48198.rjw@sisk.pl>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <201209072319.33742.rjw@sisk.pl> <504F1D19.1030702@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48099 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2IKUW1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Sep 2012 16:22:27 -0400
In-Reply-To: <504F1D19.1030702@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On Tuesday, September 11, 2012, Daniel Lezcano wrote:
> On 09/07/2012 11:19 PM, Rafael J. Wysocki wrote:
> > On Friday, September 07, 2012, Daniel Lezcano wrote:
> >> This variable is only used in the in processor_driver.c.
> >> This patch reduces the scope of the variable by moving it
> >> to this file.
> > 
> > Well, the changelog is wrong (because the scope of the variable is
> > not reduced by moving it out of the header) and I don't see the point.
> 
> Yes, you are right.
> 
> > Is there any _real_ problem with that definition in processor.h?
> 
> It is not a real problem. There is no issue fixed by this patch.
> It is just reorganizing the code little by little. The intent is to
> group what is related to cpuidle to the C files here processor_driver.c.

However, it is not recommended to put "extern something" type of declarations
into *.c files.  All of them should go into headers (although not necessarily
in include/linux for that matter).

Thanks,
Rafael
