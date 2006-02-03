From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 13:40:05 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005F343AE@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:3794 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030196AbWBCSkb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 13:40:31 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>, Erik Slagter <erik@slagter.name>
Cc: linux-acpi@vger.kernel.org


>> If I remember correctly there was some sort of windows 
>>driver supplied

>> 
>EXACTLY. It is the main problem. I'm afraid that BIOS writers 
>are writing just the basic part, and they hope that the rest will be done by the OS
>driver (which they eventually also supply, but just for the "majority"
>OS :-((( ).

Please measure the A/C power running Windows and measure the power
running Linux and report back if they are different.

>I have EXACTLY the same problem with my Clevo D610SU 
>notebook. It's a SIS

If Clevo supports Linux, then they'll not supply
a Windows-only driver.

-Len
