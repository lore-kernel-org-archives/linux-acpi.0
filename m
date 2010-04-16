From: <pat-lkml@erley.org>
Subject: Working DSDT+SSDT, what's =?UTF-8?Q?next=3F?=
Date: Fri, 16 Apr 2010 14:42:46 -0400
Message-ID: <f95d4e7ce96630fd1e07c05fd8ab2504@127.0.0.1>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from li59-9.members.linode.com ([97.107.129.9]:54297 "EHLO erley.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757722Ab0DPSvl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Apr 2010 14:51:41 -0400
Received: from home.erley.org (pool-71-115-176-202.gdrpmi.dsl-w.verizon.net [71.115.176.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pat)
	by erley.org (Postfix) with ESMTPSA id 30F6D287C7
	for <linux-acpi@vger.kernel.org>; Fri, 16 Apr 2010 18:41:19 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Ok, first time poster, long time reader.  

I have a Clevo D900T mobo based laptop.  These were only ever produced
with p4 5xx series chips, but the chipset (ICH6) supports the 6xx series. 
Because it was never produced with a 6xx cpu, a bios was never released
that supported things like EIST or EM64T.  EM64T worked fine, out of the
box.  EIST did not (due to no SSDT tables with PSS/PCT/PPC methods).  I was
able to get EIST working with a hacked-up DSDT, but I'm curious if I'm
doing everything I should.

Intel CPU Spec: http://processorfinder.intel.com/details.aspx?sSpec=SL8Q7
Intel Data Sheet:
http://download.intel.com/design/Pentium4/datashts/303128.pdf

Right now, I just have 2 C States, for 3.0Ghz and 2.8Ghz.  It's my
understanding that these are the only speeds EIST can do in this CPU.  

now, the questions:

1. Is there something I should be doing with a _CSD type entry in my
CPU{0,1} entries to signify that they're HT?
2. How can I verify that EIST is actually working?
3. How do I determine VID values? 
   a. I've just lowered VID 1 by 1, loading the system until it became
unstable, at which point I added 1 and called it good
   b. Is there any advantage to multiple VID's with 1 VID?  IE:
3ghz@1.45V, 3Ghz@1.25V
4. in the PSS table, the first entry (3000,2800 in my case), are those
just for show?
5. Are there additional features the CPU supports that, due to bios
limitation, I should enable this way (C1E?)

outline of what I've done: http://pat.erley.org/Other/P4EISTSSDT

Pat Erley

