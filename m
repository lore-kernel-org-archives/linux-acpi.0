From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Tue, 17 Jul 2007 08:39:52 -0600
Message-ID: <469CD4B8.9070506@shaw.ca>
References: <fa.IMXKKgfBkv/U+MG0xx5sLkpV2Ws@ifi.uio.no>
 <fa.+iOE+OqrQUbecN788fV4aEhLLtg@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:32140 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271AbXGQOj1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 10:39:27 -0400
In-reply-to: <fa.+iOE+OqrQUbecN788fV4aEhLLtg@ifi.uio.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Aaron Durbin <adurbin@google.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

Andi Kleen wrote:
> On Monday 16 July 2007 20:00:19 Aaron Durbin wrote:
>> Add the ability to reset the machine using the RESET_REG in ACPI's FADT table.
> 
> Why? I had such a patch at some point as experiment, but it never
> helped actually fix a box.

Depends if Windows resets using this method, in that case using it as 
well would likely prevent the steady trickle of machines that seem to 
have trouble with other reset methods and need blacklist entries..

I sometimes think that with these sorts of things where basic 
functionality like reboot is broken, people are too quick to put in 
hacks to make it work and nobody looks into why it works consistently in 
Windows but not in Linux and what we are doing differently..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

