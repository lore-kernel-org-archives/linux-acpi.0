From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 10/10] x86, ACPI: default to reboot via ACPI (again)
Date: Sat, 08 Nov 2008 02:12:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811080208590.3092@localhost.localdomain>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
 <20081107072536.GA19583@elte.hu>
 <alpine.LFD.2.00.0811072033300.9051@localhost.localdomain>
 <200811080930.21462.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:60425 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbYKHHMi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 02:12:38 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA0006BI6P0HSM5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 08 Nov 2008 01:12:37 -0600 (CST)
In-reply-to: <200811080930.21462.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrew Morton <akpm@linux-foundation.org>



> > If you can direct me to the failures that ACPI reset caused
> > in 28, that would be great. 
> 
> http://marc.info/?l=linux-kernel&m=122547719810921&w=2

Andrey,
Thanks for the quick reply.

Hmm, google on Toshiba Portege 4000 suggests it shipped with Windows 2000,
does it have a windows 2000 or a Windows XP sticker on it?

Please open up a bug report
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the dmesg, plus the output from acpidump and dmidecode.

thanks,
-Len

