From: Len Brown <lenb@kernel.org>
Subject: Re: x86 platform: oqo: select INPUT_POLLDEV
Date: Fri, 29 May 2009 20:52:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905292051260.4293@localhost.localdomain>
References: <200903041955.n24JtOKb027987@imap1.linux-foundation.org>
 <200904131916.40428.dmitry.torokhov@gmail.com> <49E4C700.6010309@oracle.com>
 <alpine.LFD.2.00.0904200026490.10996@localhost.localdomain>
 <4A135B42.2020208@oracle.com>
 <20090520022826.GA17649@dtor-d630.eng.vmware.com>
 <alpine.LFD.2.00.0905271632430.4277@localhost.localdomain>
 <20090527230356.GA29571@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:59652 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbZE3AxP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 20:53:15 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00HFGMGBQCM2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 19:53:05 -0500 (CDT)
In-reply-to: <20090527230356.GA29571@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>


> Is it public? I can pull it myself easily enough.

yes, commit id's below.

thanks,
Len Brown, Intel Open Source Technology Center


commit 261a37014c353eb392334f31f6bc2166253d12c2
Author: Randy Dunlap <randy.dunlap@oracle.com>
Date:   Tue May 26 23:59:27 2009 -0700

    oqo: select INPUT_POLLDEV
    From: Randy Dunlap <randy.dunlap@oracle.com>
    
    OQO_WMI uses INPUT_POLLDEV, but it can select that instead of 
depending on
    it, since it represents library code.
    
    Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
    Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 0eba5e81e02f5f239e3691c9e9f9afef3050b387
Author: Randy Dunlap <randy.dunlap@oracle.com>
Date:   Wed Mar 4 11:55:24 2009 -0800

    x86: oqo: depends on INPUT_POLLDEV
    
    oqo driver uses polled input functions, so make it depend
    on INPUT_POLLDEV.
    
    ERROR: "input_register_polled_device" 
[drivers/platform/x86/oqo-wmi.ko] undefined!
    ERROR: "input_allocate_polled_device" 
[drivers/platform/x86/oqo-wmi.ko] undefined!
    ERROR: "input_free_polled_device" [drivers/platform/x86/oqo-wmi.ko] 
undefined!
    ERROR: "input_unregister_polled_device" 
[drivers/platform/x86/oqo-wmi.ko] undefined!
    
    Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
    Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
    Cc: Ingo Molnar <mingo@elte.hu>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: "H. Peter Anvin" <hpa@zytor.com>
    Cc: Len Brown <lenb@kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 94c4b5977f33894cc316edf07c5cb72b5d193628
Author: Len Brown <len.brown@intel.com>
Date:   Fri Feb 6 23:06:38 2009 -0500

    oqo: dev_set_name()
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 9c82cd255907ad639bed4ffc8fcaf1bd59badb50
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Wed Dec 3 19:55:37 2008 +0000

    platform/x86: Add oqo-wmi driver for model 2 OQO backlight and rfkill 
control
    
    oqo-wmi provides a WMI-based interface to backlight and rfkill control 
on
    model 2 OQO devices. It was originally written by Brian Julin
    (<bri@abrij.org>) - I've ported it to the rfkill layer and tidied it 
up a
    little.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Len Brown <len.brown@intel.com>


