From: Manuel =?UTF-8?B?QXJnw7xlbGxlcw==?= <manuel.arguelles@gmail.com>
Subject: Re: powernow-k8: No compatible ACPI _PSS objects found. (Asrock N68-S)
Date: Fri, 14 May 2010 23:25:19 -0500
Message-ID: <hsl7ng$c70$1@dough.gmane.org>
References: <hr8dum$ivs$1@dough.gmane.org> <4BD7C0FF.5030302@erley.org> <hr8h5q$qt7$1@dough.gmane.org> <201005142308.01960.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58488 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab0EOEZd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 May 2010 00:25:33 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1OD8wO-0004qK-45
	for linux-acpi@vger.kernel.org; Sat, 15 May 2010 06:25:32 +0200
Received: from cpe-000db902aab0.cpe.cableonda.net ([190.140.181.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 15 May 2010 06:25:32 +0200
Received: from manuel.arguelles by cpe-000db902aab0.cpe.cableonda.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 15 May 2010 06:25:32 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Thomas Renninger wrote:

> That sounds promising.
Really?

> Did you update your BIOS to the latest version?
> If not, do that first.
Yes I did, the last version is 2.00
http://www.asrock.com/MB/download.asp?Model=N68-S&o=BIOS

> Are you sure you went through all BIOS configs?
This are the values:
Overclock mode: Auto
(possible options: cpu,pcie sync / cpu,pcie async, optimized)

cpu/ldt spread spectrum: disabled
pcie spread spectrum: disabled
boot fail guard: enabled
(possible options: enabled/disabled)

cool 'n' quiet: enabled
(possible options: enabled/disabled/auto)

secure virtual machine: enabled
enhanced halt state: enabled
(possible options: enabled/disabled)

L3 cache allocation: bsp only
(possible options: bsp only/all cores)

multiplier/voltage change: auto
memory clock: auto
(possible options: auto/manual)

flexibility option: disabled
(possible options: enabled/disabled)

memory controller mode: unganged
(possible options: unganged/ganged)

The following are set to auto:
CAS latency, trcd, tpp, trtp, tras, trrd, trc, twr, twtr, ma timing, 
addr/cmd fine delay, cs/odt fine delay bank intervealing

Alson on ACPI menu I have:
acpi hpet table: enabled
osc control: enabled


> Eventually you upgraded the CPUs?
The pc came with this board and this cpu, however in can't find my model in 
the cpu compatibility list: 
http://www.asrock.com/mb/cpu.asp?Model=N68-S&s=AM2

It is HDZ955FBGMBOX

> 
> Best open a bug on https://bugzilla.kernel.org and assign it to the
> cpufreq component and CC me.
> Upload DSDT, SSDTs or best just acpidump which includes all.
Do you still think I should open the bug?

Regards

