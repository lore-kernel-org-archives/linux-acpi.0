From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] Suspend,cpuidle:resume_hang fix with cpuidle
Date: Thu, 05 Jul 2012 20:07:23 -0700
Message-ID: <4FF6566B.8020409@linux.vnet.ibm.com>
References: <4FEC20D2.2070501@linux.vnet.ibm.com> <4FF1336D.10808@linux.vnet.ibm.com> <4FF1329A.7000502@linux.vnet.ibm.com> <201207022143.51489.rjw@sisk.pl> <4FF65760.9050002@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:57330 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933408Ab2GFDH7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jul 2012 23:07:59 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <dave@linux.vnet.ibm.com>;
	Thu, 5 Jul 2012 21:07:59 -0600
In-Reply-To: <4FF65760.9050002@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: preeti <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

On 07/05/2012 08:11 PM, preeti wrote:
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 6d9ec3e..b894627 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -221,10 +221,6 @@ static void lapic_timer_state_broadcast(struct
> acpi_processor *pr,
> 
>  #endif
> 
> -/*
> - * Suspend / resume control
> - */

This looks line-wrapped to me.

