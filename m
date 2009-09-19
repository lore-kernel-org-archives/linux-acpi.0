From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 5/8] acpi: switch /proc/acpi/{debug_layer,debug_level} to
 seq_file
Date: Sat, 19 Sep 2009 01:41:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909190139070.22030@localhost.localdomain>
References: <200909181941.n8IJf8fT002535@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:55012 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbZISFlh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Sep 2009 01:41:37 -0400
Received: from localhost.localdomain ([74.104.157.165])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KQ700MEDEH0IS97@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 19 Sep 2009 00:41:30 -0500 (CDT)
In-reply-to: <200909181941.n8IJf8fT002535@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, adobriyan@gmail.com

applied.

i'm really not excited about maintaining deprecated features -- 
we replaced these with files in sysfs long ago -- but it seems that it
takes forever to get people to stop using the old stuff
and i guess you could argue this is a fix rather than an enhancement,
so i guess we should do it.

thanks,
Len Brown, Intel Open Source Technology Center

