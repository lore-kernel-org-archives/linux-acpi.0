From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND PATCH 6/7] ACPI video: support buggy BIOSes with _BCQ
 implemented
Date: Tue, 17 Mar 2009 01:05:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903170105380.4473@localhost.localdomain>
References: <1236848230.2807.75.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:33093 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbZCQFFz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2009 01:05:55 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGM007YZWTSH77P@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 17 Mar 2009 00:05:53 -0500 (CDT)
In-reply-to: <1236848230.2807.75.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>

WARNING: line over 80 characters
#55: FILE: drivers/acpi/video.c:867:
+	else if 
(ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BCQ",&h_dummy1))) {

ERROR: space required after that ',' (ctx:VxV)
#55: FILE: drivers/acpi/video.c:867:
+	else if 
(ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BCQ",&h_dummy1))) {
 	                                                         ^

ERROR: space required after that ',' (ctx:VxO)
#55: FILE: drivers/acpi/video.c:867:
+	else if 
(ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BCQ",&h_dummy1))) {
 	                                                                ^

ERROR: space required before that '&' (ctx:OxV)
#55: FILE: drivers/acpi/video.c:867:
+	else if 
(ACPI_SUCCESS(acpi_get_handle(device->dev->handle,"_BCQ",&h_dummy1))) {
 	                                                                 ^

total: 3 errors, 1 warnings, 40 lines checked


--
Len Brown, Intel Open Source Technology Center

