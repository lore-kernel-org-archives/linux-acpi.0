From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/5] acpi : remove index from acpi_processor_cx structure
Date: Fri, 13 Jul 2012 20:13:05 +0200
Message-ID: <201207132013.05738.rjw@sisk.pl>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org> <201207122344.27157.rjw@sisk.pl> <4FFF4835.9030806@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:40071 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932757Ab2GMSH3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jul 2012 14:07:29 -0400
In-Reply-To: <4FFF4835.9030806@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, July 12, 2012, Daniel Lezcano wrote:
> On 07/12/2012 11:44 PM, Rafael J. Wysocki wrote:
> > On Thursday, July 12, 2012, Daniel Lezcano wrote:
> >> Remove the index field. It could be given without adding extra
> >> information in the cx structure.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > I'm not sure about this one.
> > 
> > The code seems to be more straightforward without it, actually.
> > 
> > Why exactly do you need to remove the field?
> 
> Actually, I am trying to cleaning up the different structure in the acpi
> and clearly separate what is for cpuidle and what is for acpi.
> 
> I noticed there are some duplicated informations like the index and what
> is described in the cx state.
> 
> I am trying to consolidate the code of the cpuidle drivers across the
> different platform and I have to admit the processor_idle is the most
> complicated as the cpuidle code is spreaded across different files
> (processor_driver.c, processor.h, arch/x86/kernel/acpi/cstate.c, etc
> ...). So these small patches are to litlle by little separate these two
> subsystems (acpi and cpuidle) and have everything related to cpuidle
> into the processor_idle file.
> 
> For this patch, it is right it seems to introduce more complexity but
> the objective is to consolidate the code. I hope by cleaning the
> different structures we will gain in readability.

OK, I'm generally fine with that, but I'd prefer to defer this kind of
changes to 3.7 so as to avoid rushing them in.

Removing unused fields is entirely fine at this point, I don't see how
someone may see that objectionable, but let's just avoid playing with fields
that are used for now.

Thanks,
Rafael
