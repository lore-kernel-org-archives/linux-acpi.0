From: Marc MERLIN <marc@merlins.org>
Subject: How to detect reason for ACPI wakeup?
Date: Tue, 17 Apr 2012 10:17:09 -0700
Message-ID: <20120417171709.GC5632@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:52199 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab2DQRRK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Apr 2012 13:17:10 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.77 #2)
	id 1SKC1e-0006Bb-14
	for <linux-acpi@vger.kernel.org>; Tue, 17 Apr 2012 10:17:10 -0700
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Howdy,

My HTPC goes to sleep (S3) and resumes just fine (via RTC or WOL).

My problem is that I need to know whether it woke up from RTC or WOL and I
find nothing in dmesg that gives me a clue for the wakeup reason.

Is it something that I can get from somewhere?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
