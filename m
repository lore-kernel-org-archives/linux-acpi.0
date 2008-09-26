From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 17:57:23 +0200
Message-ID: <200809261757.24585.rjw@sisk.pl>
References: <20080925170030.15311.27823.stgit@thinkpad> <200809261748.54054.rjw@sisk.pl> <48DD040B.9020807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33560 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbYIZPvo (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 26 Sep 2008 11:51:44 -0400
In-Reply-To: <48DD040B.9020807@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "Zhao, Yakui" <yakui.zhao@intel.com>, Sitsofe Wheeler <sitsofe@yahoo.com>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

On Friday, 26 of September 2008, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> > On Friday, 26 of September 2008, Alexey Starikovskiy wrote:
> >   
> >> Rafael J. Wysocki wrote:
> >>     
> >>>> He refers to the ec->curr (former ec->t).
> >>>>         
> >>> Hm, I'm not sure what the failing scenario in this case would be.
> >>>       
> >> Last one was the thread of the stack is killed during transaction,
> >> thus stack vanishes and interrupt goes over freed memory.
> >>     
> >
> > This isn't possible IMO.  The thread is uninterruptible while waiting for the
> > transaction to finish (if I'm not mistaken).
> >   
> Right, I already explained it to Yakui, this is why he only claims 
> "ugly" now.
> > That said, we can still embed 'curr' in 'struct acpi_ec' and do
> > 'ec.curr = t' instead of 'ec->curr = &t' in acpi_ec_transaction_unlocked().
> > Now, if 'command' is embedded in 'curr', it will be sufficient to do
> > 'if (curr.command)' instead of doing 'if (ec->curr)', wherever applicable.
> >   
> No, I like current way more. Now it is not possible to use transaction 
> data if
> acpi_ec_transaction is not on the stack.

OK
