From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI Regression on Dell E1501
Date: Fri, 22 Jun 2007 18:55:54 +0200
Message-ID: <1182531354.4976.9.camel@queen.suse.de>
References: <467AE7E1.4050805@canonical.com> <467AF204.3060805@redhat.com>
	 <1182462902.3316.105.camel@chaos> <467BC9F8.5000403@canonical.com>
	 <467BCC3F.4080405@canonical.com> <1182525150.28514.746.camel@queen.suse.de>
	 <adair9g2ctk.fsf@cisco.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:53983 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077AbXFVQ4A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Jun 2007 12:56:00 -0400
In-Reply-To: <adair9g2ctk.fsf@cisco.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Cc: Tim Gardner <tim.gardner@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, Chuck Ebbert <cebbert@redhat.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On Fri, 2007-06-22 at 09:06 -0700, Roland Dreier wrote:
>  > pci=nomsi let the machine still boot.
>  > 
>  > I tried a bit and I think I got it, for me it's this one:
>  > 
>  > commit 78b7611c4a1e3ff008abc4751b566cb533d68f3d
> 
> Really??  That's "msi: mask the msix vector before we unmap it" and
No, I was wrong.
I added the patches again, which I reverted and it still boots.
I horribly mixed something up here, I will try to find out tomorrow,
sorry for the confusion.

   Thomas


