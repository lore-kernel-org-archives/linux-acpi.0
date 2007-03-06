From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Tue, 06 Mar 2007 15:07:44 -0500
Message-ID: <jwvabyq6sqq.fsf-monnier+gmane.linux.kernel@gnu.org>
References: <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302151055.d2665d66.khali@linux-fr.org> <20070302141840.GA3441@srcf.ucam.org> <20070302220454.a0c66d04.khali@linux-fr.org> <20070302211251.GA10035@srcf.ucam.org> <20070303105316.d51e032d.khali@linux-fr.org> <20070305222548.GA4946@ucw.cz> <20070306162634.bcaaf0c7.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:37010 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932438AbXCFUkL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2007 15:40:11 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HOgS1-0003NC-Ty
	for linux-acpi@vger.kernel.org; Tue, 06 Mar 2007 21:40:01 +0100
Received: from bas1-montreal42-1242353373.dsl.bell.ca ([74.12.206.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 06 Mar 2007 21:40:01 +0100
Received: from monnier by bas1-montreal42-1242353373.dsl.bell.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 06 Mar 2007 21:40:01 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

>> > Is there anything preventing us from doing such a walk and pre-allocate
>> > all the I/O ranges? I am not familiar with the ACPI code at all, would
>> > you possibly propose a patch doing that?
>> 
>> ACPI AML is probably turing-complete: I'm afraid you are trying to
>> solve the halting problem (-> impossible).

> Can you please translate this into something mere humans like myself
> have a chance to understand?

Try wikipedia "Halting problem".


        Stefan

