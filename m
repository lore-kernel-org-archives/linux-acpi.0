From: Len Brown <lenb@kernel.org>
Subject: Re: [Resend] [PATCH] ACPI: Enable EC device immediately after ACPI
 full initialization
Date: Sat, 11 Oct 2008 02:00:56 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810110200230.7059@localhost.localdomain>
References: <1223260296.4023.292.camel@yakui_zhao.sh.intel.com>
 <alpine.LFD.1.10.0810101730130.7059@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:47737 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbYJKGA7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:00:59 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8K00HO78PM7LU0@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Oct 2008 01:00:58 -0500 (CDT)
In-reply-to: <alpine.LFD.1.10.0810101730130.7059@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org



On Fri, 10 Oct 2008, Len Brown wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=11374#c7
> 
> suggests that this patch will causee a regression.

Alexey send me his Ack for this one, so I've applied it to the
ec branch in acpi-test.

thanks,
-Len

