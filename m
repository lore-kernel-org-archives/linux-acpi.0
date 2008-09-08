From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: patch for bugs 9998 and 10724
Date: Mon, 08 Sep 2008 09:18:01 +0800
Message-ID: <1220836681.4007.232.camel@yakui_zhao.sh.intel.com>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>
	 <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de>
	 <48BFD609.2050604@suse.de>  <1220581596.3441.2.camel@rzhang-dt>
	 <1220586550.4007.185.camel@yakui_zhao.sh.intel.com>
	 <48C12D0A.6020704@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37497 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754818AbYIIA7F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Sep 2008 20:59:05 -0400
In-Reply-To: <48C12D0A.6020704@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, 2008-09-05 at 16:58 +0400, Alexey Starikovskiy wrote:
> Zhao Yakui wrote:
> > If the system is already switched to GPE mode, how to continue EC
> > transaction if there is no GPE interrupt confirmation in some EC
> > transaction? For example: on the laptops of bug 11428 & 8459. In fact
> > sometimes there is no EC GPE interrupt confirmation only for the last
> > step of EC transaction(OBF bit already indicates that data is ready but
> > there is no EC interrupt).
> You can't read, do you?
> 
> If the interrupt does not arrive for OBF in the middle of transaction,
> transaction will be completed after the GPE_MODE is cleared in acpi_wait()
> in a poll loop below, there is even a comment for that.
Oh, I misunderstand what you have done in the patch.
But from the patch it seems that the definition of acpi_ec_wait in the
attached patch is totally different with that in upstream kernel. Right?
In the attached patch it indicates whether the transaction is finished.
But in the upstream kernel it indicates whether the EC status is already
what OS expected.

If the function definition is totally different, you had better add some
comments. Otherwise it is too difficult to understand.

Maybe your patch is right and can work well on your laptop. But the
basic working flowchart is changed a lot, maybe it had better be tested
on more laptops. At the same time you should add more comments and
descriptions. Otherwise when the regression happens, no one can make any
improvements about the EC driver.

Best regards.
   Yakui.
> 	/* start transaction */
> 	acpi_ec_write_cmd(ec, command);
> >>>>>	/* if we selected poll mode or failed in GPE-mode do a poll loop */
> 	if (force_poll ||
> 	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
> 	    acpi_ec_wait(ec)) {
> 		delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
> 		while (time_before(jiffies, delay)) {
> 			gpe_transaction(ec, acpi_ec_read_status(ec));
> 			msleep(1);
> 			if (ec_transaction_done(ec))
> 				goto end;
> 		}
> 	}
> 

