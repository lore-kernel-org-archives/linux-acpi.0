From: Teo <teo.ubuntu@yahoo.com>
Subject: RE: hello
Date: Sun, 30 Apr 2006 04:49:56 -0700 (PDT)
Message-ID: <20060430114956.49258.qmail@web38302.mail.mud.yahoo.com>
References: <CFF307C98FEABE47A452B27C06B85BB64E8BD3@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web38302.mail.mud.yahoo.com ([209.191.125.18]:9609 "HELO
	web38302.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751100AbWD3Lt5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Apr 2006 07:49:57 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB64E8BD3@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Len,

> > pci_mmcfg_read()
> 
> try "pci=nommconf"
> 
> if it works, then, then try the latest kernel from
> kernel.org
> to see if this is specific to ubuntu or generic to
> Linux.
I downloaded and compiled 2.6.16.11 kernel - no
patches. The only change I did in configuration is
selecting my processor type - EM64T.

This kernel is working. It doesn't panic while
booting.

> If specific to ubuntu, looks like the bug you filed
> there already covers it.
Yes, but it doesn't get attention I feel.

Thanks,
Teo

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
