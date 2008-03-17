From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH] ACPI: disable stray gpe correctly
Date: Mon, 17 Mar 2008 10:09:27 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE0131BB1B@pdsmsx414.ccr.corp.intel.com>
References: <1205114649.10256.200.camel@acpi-hp-zz.sh.intel.com> <200803110206.45590.lenb@kernel.org> <47D8351F.7080802@redhat.com> <200803121609.46134.lenb@kernel.org>  <B28E9812BAF6E2498B7EC5C427F293A4046ACA22@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13043 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbYCQCJb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Mar 2008 22:09:31 -0400
Content-class: urn:content-classes:message
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4046ACA22@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Chuck Ebbert <cebbert@redhat.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, davej@redhat.com

Agree. :)
I'll work on that problem.

Thanks,
rui

>-----Original Message-----
>From: Moore, Robert
>Sent: Saturday, March 15, 2008 5:49 AM
>To: Moore, Robert; Len Brown; Chuck Ebbert
>Cc: Zhang, Rui; linux-acpi; Lin, Ming M; davej@redhat.com
>Subject: RE: [PATCH] ACPI: disable stray gpe correctly
>
>I'm going to back this out until the reported problem is resolved.
>Bob
>
>
>>-----Original Message-----
>>From: Moore, Robert
>>Sent: Wednesday, March 12, 2008 2:59 PM
>>To: 'Len Brown'; Chuck Ebbert
>>Cc: Zhang, Rui; linux-acpi; Lin, Ming M; davej@redhat.com
>>Subject: RE: [PATCH] ACPI: disable stray gpe correctly
>>
>>This patch looked fairly benign to me, so I've committed it to the
ACPICA
>>core for the next release this week.
>>
>>The comment I added for the patch looks like this:
>>
>>    /*
>>     * Ignore this if the GPE is valid and not enabled.
>>     *
>>     * Flags is only zero if GPE is neither enabled or disabled -- it
may
>>     * be a spurious or stray GPE -- disable it in the default case
below.
>>     */
>>    if (GpeEventInfo->Flags &&
>>       (!(GpeEventInfo->Flags & ACPI_GPE_ENABLE_MASK)))
>>    {
>>        return_ACPI_STATUS (AE_OK);
>>    }
>>
>>
>>If there are problems, I will back it out. Please let me know ASAP
what the
>>issue is in 436959.
>>
>>Thanks,
>>Bob
>>
>>
>>
>>>-----Original Message-----
>>>From: Len Brown [mailto:lenb@kernel.org]
>>>Sent: Wednesday, March 12, 2008 1:10 PM
>>>To: Chuck Ebbert
>>>Cc: Zhang, Rui; linux-acpi; Lin, Ming M; Moore, Robert;
davej@redhat.com
>>>Subject: Re: [PATCH] ACPI: disable stray gpe correctly
>>>
>>>
>>>> > On Sunday 09 March 2008, Zhang, Rui wrote:
>>>> >> Disable stray GPE correctly
>>>> >> https://bugzilla.redhat.com/show_bug.cgi?id=251744
>>>> >> http://bugzilla.kernel.org/show_bug.cgi?id=6217
>>>> >>
>>>> >> Sighed-off-by: Zhang Rui <rui.zhang@intel.com>
>>>> >> ---
>>>> >>  drivers/acpi/events/evgpe.c |    3 ++-
>>>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>> >>
>>>> >> Index: linux-2.6/drivers/acpi/events/evgpe.c
>>>> >>
===================================================================
>>>> >> --- linux-2.6.orig/drivers/acpi/events/evgpe.c
>>>> >> +++ linux-2.6/drivers/acpi/events/evgpe.c
>>>> >> @@ -248,7 +248,8 @@ acpi_status acpi_ev_disable_gpe(struct a
>>>> >>
>>>> >>  	ACPI_FUNCTION_TRACE(ev_disable_gpe);
>>>> >>
>>>> >> -	if (!(gpe_event_info->flags & ACPI_GPE_ENABLE_MASK)) {
>>>> >> +	if (gpe_event_info->flags &&
>>>> >> +		(!(gpe_event_info->flags &
ACPI_GPE_ENABLE_MASK))) {
>>>> >>  		return_ACPI_STATUS(AE_OK);
>>>> >>  	}
>>>> >>
>>>>
>>>> Causes ACPI battery problems...
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=436959
>>>
>>>Okay, i've droppped it until 436959 can be figured out.
>>>
>>>thanks Chuck,
>>>-Len
>>>
>>>

