From: Michael Sotnikov <astar@tut.by>
Subject: Re: ACPI on HP Pavilion dv2765tx, c-states problems
Date: Thu, 24 Apr 2008 11:17:18 +0900
Message-ID: <480FEDAE.7040102@tut.by>
References: <funj2g$obi$1@ger.gmane.org> <480F7926.1090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:48551 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbYDXCMj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Apr 2008 22:12:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Joqwr-0003oU-R2
	for linux-acpi@vger.kernel.org; Thu, 24 Apr 2008 02:12:33 +0000
Received: from 211.48.9.88 ([211.48.9.88])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 24 Apr 2008 02:12:33 +0000
Received: from astar by 211.48.9.88 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Thu, 24 Apr 2008 02:12:33 +0000
In-Reply-To: <480F7926.1090406@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I can't find my previous answer to group, just rewrite it.

Alexey Starikovskiy:
> Please check if your BIOS has EST  enabled.

there isn't any options about cpu, except C4 on/off

> If yes and you still can not load acpi_cpufreq, please provide acpidump 
> output and /proc/cpuinfo.

some information and attachments is here:
http://bugzilla.kernel.org/show_bug.cgi?id=10513

-- 
Best Regards,
Michael

