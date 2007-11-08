From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: 2.6.24-rc2 (esthetic?) regression: auto select interrupt spams
 my	logs
Date: Thu, 08 Nov 2007 14:52:25 +0300
Message-ID: <4732F879.8080005@suse.de>
References: <1194515744.7115.12.camel@rukbat>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:36525 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753291AbXKHLw4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Nov 2007 06:52:56 -0500
In-Reply-To: <1194515744.7115.12.camel@rukbat>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Romano Giannetti <romanol@upcomillas.es>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Romano,

EC was changed to automatically choose it's working mode (poll vs. interrupt driven).
You see it oscillating between modes because it receives interrupts just after it 
stops waiting for them.
Please open new bug entry at bugzilla.kernel.org.
Your .config might be usefull.

Thanks,
Alex.
Romano Giannetti wrote:
> Hi,
> 
> After the ACPI changes between 2.6.24-rc1 and -rc2 I have my logs
> "spammed" (every 2-3 seconds) by: 
> 
> [  423.112903] ACPI: EC: missing IBF_1 confirmations,switch off interrupt mode.
> [  423.113020] ACPI: EC: non-query interrupt received, switching to interrupt mode
> [  426.078972] ACPI: EC: missing IBF_1 confirmations,switch off interrupt mode.
> [  426.079645] ACPI: EC: non-query interrupt received, switching to interrupt mode
> [  426.622773] ACPI: EC: missing IBF_1 confirmations,switch off interrupt mode.
> [  426.622889] ACPI: EC: non-query interrupt received, switching to interrupt mode
> 
> It seems that no harm is done, apart (but it could be another thing)
> that gnome-panel is much slower on startup. 
> 
> Romano  
> 
> 

