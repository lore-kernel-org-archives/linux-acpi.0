From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI reads wrong temperature
Date: Mon, 03 Nov 2008 12:47:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811031246550.3132@localhost.localdomain>
References: <20081031140247.325670@gmx.net>
 <20081031143030.GA9177@srcf.ucam.org> <20081031210913.3180@gmx.net>
 <20081102092541.GE10983@srcf.ucam.org> <20081102113112.316040@gmx.net>
 <1225677936.26020.17.camel@yakui_zhao.sh.intel.com>
 <20081103090153.250280@gmx.net>
 <9F0C1DB20AFA954FA1DA05309350433D3E5CA72D@pdsmsx503.ccr.corp.intel.com>
 <20081103145723.GB496@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:45226 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbYKCRrd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 12:47:33 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9R00BRAQQX6427@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 03 Nov 2008 11:47:22 -0600 (CST)
In-reply-to: <20081103145723.GB496@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Zhao, Yakui" <yakui.zhao@intel.com>, Peter Mahlknecht <mali100@gmx.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


> I don't think the BIOS is doing anything wrong here. It's entitled to 
> assume that the operating system won't load drivers for hardware it's 
> not declaring.

agreed, we need a linux solution.

-len
