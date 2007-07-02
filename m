From: Dag Bakke <dag@bakke.com>
Subject: Re: [PATCH] Enable C3 Power State on Dell Inspiron 8200
Date: Mon, 02 Jul 2007 18:02:24 +0200
Message-ID: <46892190.7000500@bakke.com>
References: <468024A5.4010505@bakke.com> <200706261730.12935.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:58983 "EHLO
	bgo1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbXGBQC0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jul 2007 12:02:26 -0400
Received: from bgo1sminn1.broadpark.no ([217.13.4.93])
 by bgo1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JKK00IO8781Z100@bgo1smout1.broadpark.no> for
 linux-acpi@vger.kernel.org; Mon, 02 Jul 2007 18:02:25 +0200 (CEST)
Received: from [10.0.0.3] ([84.48.89.144]) by bgo1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JKK00CTC778GK20@bgo1sminn1.broadpark.no> for
 linux-acpi@vger.kernel.org; Mon, 02 Jul 2007 18:01:56 +0200 (CEST)
In-reply-to: <200706261730.12935.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, arjan@linux.intel.com

Len Brown wrote:
> Does this system have a _CST in its DSDT?
> 
> Can you attach the output of acpidump to a bugzilla.kernel.org entry?
> Also, the complete output from dmesg -s64000

http://bugzilla.kernel.org/show_bug.cgi?id=8703


Dag B
