From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Bisection result: eeepc hotk breakage
Date: Fri, 31 Oct 2008 10:26:42 +0000
Message-ID: <490ADD62.7090507@tuffmail.co.uk>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com> <4908307C.8060503@tuffmail.co.uk> <49086F67.1030607@suse.de> <490872BF.2010908@tuffmail.co.uk> <4908C714.5040104@tuffmail.co.uk> <4908C8EB.1010403@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:15663 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYJaK0s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 06:26:48 -0400
Received: by ey-out-2122.google.com with SMTP id 6so406683eyi.37
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2008 03:26:46 -0700 (PDT)
In-Reply-To: <4908C8EB.1010403@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>

Alexey Starikovskiy wrote:
>
> Alan Jenkins wrote:
>> Well, that didn't work.
> Pity...
> Could you produce a debug log from EC?
> Probably it's a good time to open a new bug report...

<http://bugzilla.kernel.org/show_bug.cgi?id=11917>
"Asus Eee PC hotkeys stop working after prolonged usage"

I stuck at it, found a reliable test and bisected successfully. 
2.6.28-rc2 is broken, but I can fix it by reverting the bad commit. 
(There were some conflicts, I fixed up the dock driver manually and
avoided building the rest).



27663c5855b10af9ec67bc7dfba001426ba21222 is first bad commit
commit 27663c5855b10af9ec67bc7dfba001426ba21222
Author: Matthew Wilcox <willy@linux.intel.com>
Date:   Fri Oct 10 02:22:59 2008 -0400

    ACPI: Change acpi_evaluate_integer to support 64-bit on 32-bit kernels

    As of version 2.0, ACPI can return 64-bit integers.  The current
    acpi_evaluate_integer only supports 64-bit integers on 64-bit platforms.
    Change the argument to take a pointer to an acpi_integer so we support
    64-bit integers on all platforms.

    lenb: replaced use of "acpi_integer" with "unsigned long long"
    lenb: fixed bug in acpi_thermal_trips_update()

    Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
