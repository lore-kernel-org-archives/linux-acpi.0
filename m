From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Wed, 1 Feb 2006 13:11:36 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005E907CA@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:447 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932448AbWBASNK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Feb 2006 13:13:10 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Joerg Sommrey <jo@sommrey.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, arjan@infradead.org, Tony Lindgren <tony@atomide.com>

 
>>  This patch can also be found at
>>  http://www.sommrey.de/amd76x_pm/amd76x_pm-2.6.15-4.patch
>> 
>>  In this version more locking was added to make sure all or 
>>  no CPU enter C3 mode.
>> 
>>  Signed-off-by: Joerg Sommrey <jo@sommrey.de>
>
>Thanks.  I'll merge this into -mm and shall plague the ACPI 
>guys with it. 
>They have said discouraging things about board-specific drivers in the
>past.  We shall see.

Linux/ACPI has had generic supported SMP deep (> C1) C-states
for a few months now and AFAIK it is working fine.
Why is a platform specific driver needed for these boards?

-Len
