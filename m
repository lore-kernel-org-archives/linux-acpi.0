From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] hp-wmi: Fix memleaks by freeing acpi buffers delcared
 as ACPI_ALLOCATE_BUFFER
Date: Wed, 16 Dec 2009 13:03:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912161303070.6089@localhost.localdomain>
References: <1256575458-19269-1-git-send-email-trenn@suse.de>
 <1256575458-19269-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:49118 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756750AbZLPSD1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 13:03:27 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUR00FJ0BHDVSS0@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 12:03:14 -0600 (CST)
In-reply-to: <1256575458-19269-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

applied

thanks,
Len Brown, Intel Open Source Technology Center

