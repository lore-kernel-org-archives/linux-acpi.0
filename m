From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 11/12] ACPI: use of ACPI_FADT_32BIT_TIMER is not allowed in HW reduced mode
Date: Fri, 22 Nov 2013 13:08:53 +0100
Message-ID: <4190385.1cnkRW6cdN@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <528D3488.9080905@linaro.org> <528E9ABF.1020003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50351 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753277Ab3KVL4L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 06:56:11 -0500
In-Reply-To: <528E9ABF.1020003@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Thursday, November 21, 2013 04:43:59 PM Al Stone wrote:
> On 11/20/2013 03:15 PM, Al Stone wrote:
> > On 11/17/2013 03:26 PM, Rafael J. Wysocki wrote:
> >> On Saturday, November 09, 2013 06:36:21 PM al.stone@linaro.org wrote:
> >>> From: Al Stone <ahs3@redhat.com>
> >>
> >> I'm reading the patch as "the timer resolution in HW reduced mode is
> >> always
> >> 32-bit".  Is my reading correct?
> >
> > Whups, I see what I did.  You are reading the patch correctly.
> >
> > However, what the code should ultimately do is ignore the
> > ACPI_FADT_32BIT_TIMER flag completely.  Let me look at where the
> > timer_resolution field is being used also since it is not immediately
> > clear what value it should have, or if it should even be used, when
> > in reduced HW mode.
> 
> On further investigation, I'll take this patch out of this set.
> I think this needs better handling in the ACPICA code so I'll work
> with them on that.
> 
> In the meantime, the spec seems to be completely mum on what the
> timer resolution should be in reduced HW mode.

If that's about the ACPI PM timer, that's because it's not present
at all in HW reduced mode.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
