From: "Eugene Ewe Otto" <eeo5w@cms.mail.virginia.edu>
Subject: How trip_points works
Date: Mon, 10 Apr 2006 21:02:50 -0400
Message-ID: <web-191114550@cgatepro-4.mail.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fork11.mail.Virginia.EDU ([128.143.2.181]:54993 "EHLO
	fork11.mail.virginia.edu") by vger.kernel.org with ESMTP
	id S932238AbWDKBCw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Apr 2006 21:02:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I want to modify my thermal trip points but it doesn't seem to be working. 
 When I try to echo a new set of values into the trip_points file (as per 
the docs on the ACPI website) nothing changes.

When I cat trip_points, I only have a critical temperature point set at 99 C 
-- does this mean that passive and active cooling are handled by BIOS? If 
this is the case, can I make ACPI responsible for handling trip points or 
would it be better to modify the DSDT with the trip point values I want?

Thanks a lot!

-Eugene
