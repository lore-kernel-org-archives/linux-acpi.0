From: Len Brown <lenb@kernel.org>
Subject: Re: acpi-test tree build failure
Date: Thu, 16 Oct 2008 11:34:59 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810161133240.3026@localhost.localdomain>
References: <48F0761D.9060209@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53475 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYJPPfb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 11:35:31 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8U00NMK8MC4NL0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 16 Oct 2008 10:35:01 -0500 (CDT)
In-reply-to: <48F0761D.9060209@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>



On Sat, 11 Oct 2008, Alan Jenkins wrote:

> I tried acpi-test to see how it works on my EeePC (with the nasty EC),
> but the build fails, complaining about a non-existent file...
> 
>     $ make ARCH=i386 oldconfig
>     scripts/kconfig/conf -o arch/x86/Kconfig
>     arch/x86/Kconfig:1539: can't open file "drivers/idle/Kconfig"
>     make[1]: *** [oldconfig] Error 1
>     make: *** [oldconfig] Error 2
> 
> I can see where the reference to drivers/idle was added, so I've
> reverted it locally.  I hope I'm not looking at the wrong tree or
> something :-).

it was a real bug.
probably i forgot to manually add this file, which git makes
me do when i resolve merge conflicts.  didn't notice it b/c
the untracked Kconfig file was still sitting there when I needed it.

thanks,
-Len
