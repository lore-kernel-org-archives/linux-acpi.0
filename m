From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Tue, 14 Dec 2010 23:03:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012142302110.4878@x980>
References: <20101214220932.GA1206@sgi.com>
 <alpine.LFD.2.00.1012141903210.25387@x980> <20101215024136.GB19601@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:53068 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759208Ab0LOEDp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Dec 2010 23:03:45 -0500
In-reply-to: <20101215024136.GB19601@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Steiner <steiner@sgi.com>
Cc: hpa@zytor.com, hmh@hmh.eng.br, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

-       free_initmem();
+//     free_initmem();

allows this patch to boot, so the problem is with use of code and 
data marked __init.

thanks,
Len Brown, Intel Open Source Technology Center

