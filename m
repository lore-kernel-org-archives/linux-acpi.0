From: "Brown, Len" <len.brown@intel.com>
Subject: RE: debugging 600E
Date: Mon, 30 Jan 2006 17:55:07 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005E22331@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:23020 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S964900AbWA3WzP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2006 17:55:15 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi@vger.kernel.org


>From <http://bugzilla.kernel.org/show_bug.cgi?id=5966>

>Probably they've marked all the dates as 11-30-99

Yes, this seems to be true.
I did get a battery and updated to the latest 600E BIOS and the date is unchanged.
But as I build with CONFIG_ACPI_BLACKLIST_YEAR=0 this isn't an issue.

>Unfortunately, the laptop doesn't even recognize the battery (even
>after a reboot).  'acpi' stalls for 5-10 seconds, and the dmesg has
>many of these lines
>
>     osl-0854 [545] os_wait_semaphore     : Failed to acquire
>        semaphore[e3fce660|1|0], AE_TIME
>     osl-0854 [545] os_wait_semaphore     : Failed to acquire
>        semaphore[e3fce660|1|100], AE_TIME

Probably an EC issue.  Do you still see this with the latest
ACPI patch or mm tree (which includes EC interrupt mode).

thanks,
-Len
