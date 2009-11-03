From: Len Brown <lenb@kernel.org>
Subject: Re: scheduling while atomic acpi_idle_enter_bm
Date: Mon, 02 Nov 2009 22:02:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911022156420.21361@localhost.localdomain>
References: <43e72e890910271640n7fafc8edpc14143fcfca7df60@mail.gmail.com>
 <20091027165345.3237d3df@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:50096 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbZKCDDn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2009 22:03:43 -0500
In-reply-to: <20091027165345.3237d3df@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Luis R. Rodriguez" <mcgrof@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> > I get this when modprobing some module I am working on. I figured it
> > was the module's fault but the EIP points to something else so I am
> > not sure. I get the following repeating about 4 times on 2.6.32-rc5:
> 
> 
> you can get this if your own code leaves interrupts disabled in a
> kernel thread and then lets the cpu go idle...

Unclear.

acpi_enter_idle_bm() assumes that it is entered with irqs enabled,
and so it we unconditionally disables IRQs.

Then we unconditionally re-enable them.

The problem seems to be that right after we enable them,
we find that they are actually disabled, perhaps as
a side-effect of SMM.

Is your machine a Dell, per chance?

Please test the patches in this bug report:
http://bugzilla.kernel.org/show_bug.cgi?id=14101

thanks,
Len Brown, Intel Open Source Technology Center 
