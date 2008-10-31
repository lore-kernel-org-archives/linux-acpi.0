From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: Bisection result: eeepc hotk breakage
Date: Fri, 31 Oct 2008 16:51:04 +0300
Message-ID: <490B0D48.7040209@suse.de>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com> <4908307C.8060503@tuffmail.co.uk> <49086F67.1030607@suse.de> <490872BF.2010908@tuffmail.co.uk> <4908C714.5040104@tuffmail.co.uk> <4908C8EB.1010403@suse.de> <490ADD62.7090507@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:50363 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750979AbYJaNvI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 09:51:08 -0400
In-Reply-To: <490ADD62.7090507@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>


Alan Jenkins wrote:
> Alexey Starikovskiy wrote:
>> Alan Jenkins wrote:
>>> Well, that didn't work.
>> Pity...
>> Could you produce a debug log from EC?
>> Probably it's a good time to open a new bug report...
> 
> <http://bugzilla.kernel.org/show_bug.cgi?id=11917>
> "Asus Eee PC hotkeys stop working after prolonged usage"
> 
> I stuck at it, found a reliable test and bisected successfully. 
> 2.6.28-rc2 is broken, but I can fix it by reverting the bad commit. 
> (There were some conflicts, I fixed up the dock driver manually and
> avoided building the rest).
Alan, to make things clear -- reverting following commit makes EC work without
a problem?

Thanks,
Alex.
> 
> 
> 
> 27663c5855b10af9ec67bc7dfba001426ba21222 is first bad commit
> commit 27663c5855b10af9ec67bc7dfba001426ba21222
> Author: Matthew Wilcox <willy@linux.intel.com>
> Date:   Fri Oct 10 02:22:59 2008 -0400
> 
>     ACPI: Change acpi_evaluate_integer to support 64-bit on 32-bit kernels
> 
>     As of version 2.0, ACPI can return 64-bit integers.  The current
>     acpi_evaluate_integer only supports 64-bit integers on 64-bit platforms.
>     Change the argument to take a pointer to an acpi_integer so we support
>     64-bit integers on all platforms.
> 
>     lenb: replaced use of "acpi_integer" with "unsigned long long"
>     lenb: fixed bug in acpi_thermal_trips_update()
> 
>     Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>

