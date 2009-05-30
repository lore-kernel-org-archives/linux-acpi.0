From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]: ACPI: Add HP nc6000 into DMI power check table to disable
 power state check in power transition
Date: Fri, 29 May 2009 20:49:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905292048490.4293@localhost.localdomain>
References: <1242005283.3773.136.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:60714 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbZE3Atc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 20:49:32 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00CRYMAJ4TV3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 19:49:34 -0500 (CDT)
In-reply-to: <1242005283.3773.136.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

NAK
this was fixed by 19bde778c1fd2574cc020a618d7d576f260271ca
"ACPI: suspend: don't let device _PS3 failure prevent suspend"

thanks,
Len Brown, Intel Open Source Technology Center
