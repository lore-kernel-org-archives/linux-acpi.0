From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: patch for bugs 9998 and 10724
Date: Fri, 05 Sep 2008 16:58:50 +0400
Message-ID: <48C12D0A.6020704@suse.de>
References: <1219730254.4116.38.camel@yakui_zhao.sh.intel.com>	 <20080904121820.GC18288@one.firstfloor.org> <48BFD5AA.3090006@suse.de>	 <48BFD609.2050604@suse.de>  <1220581596.3441.2.camel@rzhang-dt> <1220586550.4007.185.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:60427 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751395AbYIEM64 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2008 08:58:56 -0400
In-Reply-To: <1220586550.4007.185.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Zhao Yakui wrote:
> If the system is already switched to GPE mode, how to continue EC
> transaction if there is no GPE interrupt confirmation in some EC
> transaction? For example: on the laptops of bug 11428 & 8459. In fact
> sometimes there is no EC GPE interrupt confirmation only for the last
> step of EC transaction(OBF bit already indicates that data is ready but
> there is no EC interrupt).
You can't read, do you?

If the interrupt does not arrive for OBF in the middle of transaction,
transaction will be completed after the GPE_MODE is cleared in acpi_wait()
in a poll loop below, there is even a comment for that.

	/* start transaction */
	acpi_ec_write_cmd(ec, command);
>>>>>	/* if we selected poll mode or failed in GPE-mode do a poll loop */
	if (force_poll ||
	    !test_bit(EC_FLAGS_GPE_MODE, &ec->flags) ||
	    acpi_ec_wait(ec)) {
		delay = jiffies + msecs_to_jiffies(ACPI_EC_DELAY);
		while (time_before(jiffies, delay)) {
			gpe_transaction(ec, acpi_ec_read_status(ec));
			msleep(1);
			if (ec_transaction_done(ec))
				goto end;
		}
	}

