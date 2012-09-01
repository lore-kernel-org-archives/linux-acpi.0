From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi : remove power from acpi_processor_cx structure
Date: Sat, 1 Sep 2012 07:54:58 +0200
Message-ID: <201209010754.58999.rjw@sisk.pl>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org> <20120724210629.GA1149@phenom.dumpdata.com> <50410811.70500@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:40221 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279Ab2IAFsq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Sep 2012 01:48:46 -0400
In-Reply-To: <50410811.70500@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xensource.com, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Friday, August 31, 2012, Daniel Lezcano wrote:
> On 07/24/2012 11:06 PM, Konrad Rzeszutek Wilk wrote:
> > On Tue, Jul 24, 2012 at 11:12:29PM +0200, Daniel Lezcano wrote:
> >> Remove the power field as it is not used.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Acked.
> 
> Hi Rafael,
> 
> I did not see this patch going in. Is it possible to merge it ?

I think so.  I'll take care of it when I get back from LinuxCon/Plumbers Conf.
(early next week).

Thanks,
Rafael


> >> ---
> >>  drivers/acpi/processor_idle.c    |    2 --
> >>  drivers/xen/xen-acpi-processor.c |    1 -
> >>  include/acpi/processor.h         |    1 -
> >>  3 files changed, 0 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> >> index e589c19..90582fb 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -483,8 +483,6 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
> >>  		if (obj->type != ACPI_TYPE_INTEGER)
> >>  			continue;
> >>  
> >> -		cx.power = obj->integer.value;
> >> -
> >>  		current_count++;
> >>  		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
> >>  
> >> diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
> >> index 7ff2569..7ef9c1d 100644
> >> --- a/drivers/xen/xen-acpi-processor.c
> >> +++ b/drivers/xen/xen-acpi-processor.c
> >> @@ -98,7 +98,6 @@ static int push_cxx_to_hypervisor(struct acpi_processor *_pr)
> >>  
> >>  		dst_cx->type = cx->type;
> >>  		dst_cx->latency = cx->latency;
> >> -		dst_cx->power = cx->power;
> >>  
> >>  		dst_cx->dpcnt = 0;
> >>  		set_xen_guest_handle(dst_cx->dp, NULL);
> >> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> >> index 64ec644..db427fa 100644
> >> --- a/include/acpi/processor.h
> >> +++ b/include/acpi/processor.h
> >> @@ -59,7 +59,6 @@ struct acpi_processor_cx {
> >>  	u8 entry_method;
> >>  	u8 index;
> >>  	u32 latency;
> >> -	u32 power;
> >>  	u8 bm_sts_skip;
> >>  	char desc[ACPI_CX_DESC_LEN];
> >>  };
> > _______________________________________________
> > linaro-dev mailing list
> > linaro-dev@lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-dev
> >
> 
> 
> 

