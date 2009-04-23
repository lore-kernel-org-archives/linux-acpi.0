From: Len Brown <lenb@kernel.org>
Subject: Re: [Bugme-new] [Bug 13145] New: Processor does not go below C2 if
 mouse (uhci) is plugged in.
Date: Wed, 22 Apr 2009 20:40:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904222037230.21119@localhost.localdomain>
References: <Pine.LNX.4.44L0.0904221050110.3405-100000@iolanthe.rowland.org>
 <200904221936.38942.oliver@neukum.org>
 <alpine.LFD.2.00.0904221848380.21119@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:53626 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbZDWAkz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2009 20:40:55 -0400
In-reply-to: <alpine.LFD.2.00.0904221848380.21119@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, rui.zhang@intel.com, shaohua.li@intel.com, yakui.zhao@intel.com, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, daniel.smoczyk@gmail.com, imrehg@gmail.com, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>


> That bug was fixed by commit fc2e4009300088813c3be2de80b01ddc2399999e
> "cpuidle: update the last_state acpi cpuidle reflecting actual state entered"
> 
> which shipped in 2.6.27

Venki pointed out that fc2e4009300 shipped in 2.6.27.15.
It was backported from addbad46ed0906cd584784423b9d0babc7476446
which shipped in 2.6.28

-Len Brown, Intel Open Source Technology Center
