From: <pat-lkml@erley.org>
Subject: MWAIT... How is it's use =?UTF-8?Q?decided=3F?=
Date: Fri, 30 Apr 2010 16:51:42 -0400
Message-ID: <8370cf5099deada43bf7cc64b06ae25b@127.0.0.1>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from li59-9.members.linode.com ([97.107.129.9]:42381 "EHLO erley.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045Ab0D3Uvp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Apr 2010 16:51:45 -0400
Received: from home.erley.org (pool-71-115-176-202.gdrpmi.dsl-w.verizon.net [71.115.176.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pat)
	by erley.org (Postfix) with ESMTPSA id 49A8C289F8
	for <linux-acpi@vger.kernel.org>; Fri, 30 Apr 2010 20:49:35 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have a p4 630 in a system that only supported through the 
P4 5xx series chips.  I've written a custom DSDT that added 
C-States[C1-C4] and P-States[2.8+3.0Ghz, with a little VID
drop], and have acpi-cpufreq working quite well with it.  

The only things I can think of left are getting MWAIT/C1E
working and TM2.  TM2 isn't a big concern of mine, as I
rarely get it hot, but C1E would be neat to enable.  I 
just can't figure out what to do to do it though.  If I
pass idle=mwait on the kernel command line, it disables 
acpi-cpufreq, or disables my custom DSDT table (not sure 
which).  But with idle=mwait, it works, but no cpufreq
or C-States.  can anyone provide a pointer as to what
to look at to fix this?

Pat Erley
