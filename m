From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: [PATCH] allow the highest frequency if bios think so.
Date: Tue, 21 Nov 2006 14:51:54 +0100
Message-ID: <20061121135154.GL4945@poupinou.org>
References: <20061121103042.GI4945@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:19251 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1030969AbWKUNwZ
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 08:52:25 -0500
Content-Disposition: inline
In-Reply-To: <20061121103042.GI4945@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: davej@redhat.com
Cc: cpufreq@lists.linux.org.uk, linux-acpi@vger.kernel.org

On Tue, Nov 21, 2006 at 11:30:42AM +0100, Bruno Ducrot wrote:
> Hi all,
> 
> processor_perflib.c::acpi_processor_ppc_notifier() check if the value
> returned by the processor's _PPC method is 0 and return failed if so.
> This is wrong since 0 indicate that the bios think the processor can go
> to the highest frequency.  This patch for example fix the HP NX 6125 to
> allow its highest frequency to be available.
> 
> Signed-off-by: Bruno Ducrot <ducrot@poupinou.org>
> 
> --- linux-2.6.19-rc6/drivers/acpi/processor_perflib.c	2006/11/21 10:18:39	1.1
> +++ linux-2.6.19-rc6/drivers/acpi/processor_perflib.c	2006/11/21 10:18:55
> @@ -83,8 +83,6 @@ static int acpi_processor_ppc_notifier(s
>  		goto out;
>  
>  	ppc = (unsigned int)pr->performance_platform_limit;
> -	if (!ppc)
> -		goto out;
>  
>  	if (ppc > pr->performance->state_count)

BTW I'm wondering if this check should be :
	if (ppc >= pr->performance->state_count)
>  		goto out;


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
