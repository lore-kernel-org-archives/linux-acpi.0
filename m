From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 1/2] fix acpi ec read write bug
Date: Thu, 11 Sep 2008 13:54:56 +0800
Message-ID: <1221112496.3989.233.camel@yakui_zhao.sh.intel.com>
References: <1221103065-9123-1-git-send-email-kexin.hao@windriver.com>
	 <d41e1c0a5be061176c65db7ef42263f75ae84dcb.1221102420.git.kexin.hao@windriver.com>
	 <1221106057.3989.228.camel@yakui_zhao.sh.intel.com>
	 <1221108565.11106.12.camel@kevin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45580 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbYIKFkR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 01:40:17 -0400
In-Reply-To: <1221108565.11106.12.camel@kevin>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin Hao <kexin.hao@windriver.com>
Cc: ak@linux.intel.com, astarikovskiy@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 2008-09-11 at 12:49 +0800, Kevin Hao wrote:
> On Thu, 2008-09-11 at 12:07 +0800, Zhao Yakui wrote:
> > On Thu, 2008-09-11 at 11:17 +0800, Kevin Hao wrote:
> > > Fill in command unit of transaction_data structure, otherwise
> > > gpe_transaction will skip read or write instruction.
> > > 
> > > Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
> > > ---
> > >  drivers/acpi/ec.c |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > > index bd3555c..0c65e82 100644
> > > --- a/drivers/acpi/ec.c
> > > +++ b/drivers/acpi/ec.c
> > > @@ -240,6 +240,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
> > >  	}
> > >  	atomic_set(&ec->irq_count, 0);
> > >  	/* fill in transaction structure */
> > > +	ec->t.command = command;
> > It is also OK to add this explicitly. In fact the ec->t.command will be
> > assigned in the function of acpi_ec_write_cmd.
> 
> NO, I am using the latest linux-next kernel and I don't found
> ec->t.command is assigned in acpi_ec_write_cmd function.

static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
 {
 	pr_debug(PREFIX "<--- command = 0x%2.2x\n", command);
-	outb(command, ec->command_addr);
+	outb((ec->t.command = command), ec->command_addr);
 }

It is very obscure so that it is not easy to understand.
> Thanks,
> Kevin
> 
> > 
> > Thanks.
> > >  	ec->t.wdata = wdata;
> > >  	ec->t.wlen = wdata_len;
> > >  	ec->t.rdata = rdata;
> > 

