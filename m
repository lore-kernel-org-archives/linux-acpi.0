From: Pavel Troller <patrol@sinus.cz>
Subject: Intel Entry Server Board - No CPU PM available
Date: Thu, 16 Mar 2006 15:44:42 +0100
Message-ID: <20060316144442.GA13141@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:11460 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1751161AbWCPOoo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Mar 2006 09:44:44 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5/8.13.5) with ESMTP id k2GEiggZ016069
	for <linux-acpi@vger.kernel.org>; Thu, 16 Mar 2006 15:44:42 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5/8.13.5/Submit) id k2GEiguD016068
	for linux-acpi@vger.kernel.org; Thu, 16 Mar 2006 15:44:42 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
  The following question is targeted to the Intel folks, which are for sure
here and actively helping the Linux ACPI community.
  We've purchased two pieces of "Intel Server Platform SR1425BK1-E" chassis.
  They contain SE7221BK1-E motherboard.
  We've equipped them with P-4's of adequate performance and with 1 GB of
RAM each.
  After installing Linux, I was curious, how the CPU power management is
working. What I've found, made me feel sad. It looked as in the worst and
cheapest, anonymous mobo. Just C1 available, P_LVL2_LAT=101, P_LVL3_LAT=1001.
The same cheap trick for disabling ACPI functionality as so many times
discussed here.
  I know that one can say "It's a server, it's made for heavy crunching all
the time, so what to do with ACPI PM here?" But I don't think so. Because it's
a server, it will run for many years 24/7/365. It can save a lot of resources
and give a big gift to all the Earth environment by saving so much power, 
as is possible. 
  Is there a chance to get ACPI CPU PM working here, for example by changing
BIOS, its configuration, hidden jumper or anything else ? Or is this just
the next one in the long row of ACPI-unfriendly products ?
               With regards, Pavel Troller
