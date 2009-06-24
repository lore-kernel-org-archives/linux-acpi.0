From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI video: ignore buggy _BQC
Date: Wed, 24 Jun 2009 02:09:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906240209160.32742@localhost.localdomain>
References: <1245820142.15520.112.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:37444 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZFXGJa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2009 02:09:30 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLQ00F62BRVNUL5@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 24 Jun 2009 01:09:33 -0500 (CDT)
In-reply-to: <1245820142.15520.112.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, showard314@gmail.com

scripts/checkpatch.pl
ERROR: code indent should use tabs where possible
#38: FILE: drivers/acpi/video.c:613:
+ ^I^I^Ifor (i = 2; i < device->brightness->count; i++)$

ERROR: code indent should use tabs where possible
#39: FILE: drivers/acpi/video.c:614:
+ ^I^I^I        if (device->brightness->levels[i] == *level) {$

ERROR: code indent should use tabs where possible
#40: FILE: drivers/acpi/video.c:615:
+ ^I^I^I^I        device->brightness->curr = *level;$

ERROR: code indent should use tabs where possible
#41: FILE: drivers/acpi/video.c:616:
+ ^I^I^I                return 0;$

ERROR: code indent should use tabs where possible
#42: FILE: drivers/acpi/video.c:617:
+ ^I^I^I        }$

ERROR: code indent should use tabs where possible
#43: FILE: drivers/acpi/video.c:618:
+ ^I^I^I/* BQC returned an invalid level. Stop using it.  */$

ERROR: code indent should use tabs where possible
#44: FILE: drivers/acpi/video.c:619:
+ ^I^I^IACPI_WARNING((AE_INFO, "%s returned an invalid level",$

ERROR: code indent should use tabs where possible
#45: FILE: drivers/acpi/video.c:620:
+ ^I^I^I^I      buf));$

ERROR: code indent should use tabs where possible
#46: FILE: drivers/acpi/video.c:621:
+ ^I^I^Idevice->cap._BQC = device->cap._BCQ = 0;$

total: 9 errors, 0 warnings, 24 lines checked

