From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: revert 2f894ef9
Date: Sat, 11 Apr 2009 00:59:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904110057510.11866@localhost.localdomain>
References: <1239155069.7661.108.camel@rzhang-dt>
 <alpine.LFD.2.00.0904110009440.11866@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:46954 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbZDKFAE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Apr 2009 01:00:04 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHX0022Z778C5JI@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 10 Apr 2009 23:59:39 -0500 (CDT)
In-reply-to: <alpine.LFD.2.00.0904110009440.11866@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

>  		/* 4) Fourth subobject: Dereference the PRT.source_index */
>  
> -		obj_desc = sub_object_list[source_index_index];
> +		obj_desc = sub_object_list[4];

bah, I typed [3] as [4]...
I'd like to blame it on lack of magic numbers,
but i think instead i'm just too sleepy...

thanks,
Len Brown, Intel Open Source Technology Center

