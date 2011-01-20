From: Edwin Bennink <edwin@svi.nl>
Subject: Read the local apic id of the current logical processor
Date: Thu, 20 Jan 2011 14:19:13 +0100
Message-ID: <4D383651.3010206@svi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from griet.svi.nl ([193.141.172.41]:64484 "EHLO griet.svi.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620Ab1ATN2X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jan 2011 08:28:23 -0500
Received: from [213.53.105.37] (barracuda.svi.nl [213.53.105.37])
	by griet.svi.nl (Postfix) with ESMTP id E3274308099
	for <linux-acpi@vger.kernel.org>; Thu, 20 Jan 2011 14:19:13 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear acpi list members,


I'm not sure if this is the correct place to post this question, but I'm 
looking for a way to read the local apic id (not the initial one) of the 
current logical processor in a simple user-space program.
According to the documentation I found, this local apic id is stored in 
a memory mapped msr register. Unfortunately I could not find a way to 
access this value from within user-space. All search results on the web 
involved kernel code...

The purpose of getting this id is to determine the processor hierarchy 
on a cluster; i.e. the number of logical processors, physical 
processors, packages, and nodes. The initial apic id (the one cpuid 
returns) is set by the bios and therefore it does not distinguish 
between the nodes in a cluster.

Any other way to get some kind of node id for the current logical 
processor makes me happy too :-)


Best,
Edwin



ps. I posted the same message in the linux-smp list earlier, but after 
that I noticed that the list was dead...
