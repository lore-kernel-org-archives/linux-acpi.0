From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] hp-wmi: Fix memleaks by freeing acpi buffers delcared
 as ACPI_ALLOCATE_BUFFER
Date: Wed, 16 Dec 2009 14:20:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912161419140.10371@localhost.localdomain>
References: <1256575458-19269-1-git-send-email-trenn@suse.de>
 <1256575458-19269-3-git-send-email-trenn@suse.de>
 <alpine.LFD.2.00.0912161303070.6089@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_hu5vqdYlNlGTVG4/waDSHw)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50583 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935357AbZLPTUQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 14:20:16 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUR00ARZF1RVA31@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 13:20:15 -0600 (CST)
In-reply-to: <alpine.LFD.2.00.0912161303070.6089@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_hu5vqdYlNlGTVG4/waDSHw)
Content-type: TEXT/PLAIN; charset=ISO-8859-7
Content-transfer-encoding: 8BIT

dropped.

maybe this patch is stale or i screwed up merging it...

drivers/platform/x86/hp-wmi.c: In function ¡hp_wmi_notify¢:
drivers/platform/x86/hp-wmi.c:390: error: request for member ¡pointer¢ in 
something not a structure or union

thanks,
Len Brown, Intel Open Source Technology Center

--Boundary_(ID_hu5vqdYlNlGTVG4/waDSHw)--
