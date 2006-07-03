From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: RFC [PATCH] acpi: allow SMBus access
Date: Mon, 3 Jul 2006 14:51:56 +0200
Message-ID: <20060703125156.GD17014@poupinou.org>
References: <17576.14005.767262.868190@phoenix.squirrel.nl> <20060703082217.GB17014@poupinou.org> <m2mzbrj5yp.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:51734 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1750913AbWGCMv7
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Jul 2006 08:51:59 -0400
Content-Disposition: inline
In-Reply-To: <m2mzbrj5yp.fsf@phoenix.squirrel.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johan Vromans <jvromans@squirrel.nl>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jul 03, 2006 at 01:14:22PM +0200, Johan Vromans wrote:
> Bruno Ducrot <ducrot@poupinou.org> writes:
> 
> > I don't think this patch is correct, or else I would have already
> > asked this patch being added to mainline.
> 
> You've been standing at the origins of where this patch came from. Can
> you provide a better alternative?
> 

If you want this patch to be applied, I think you should at least
mark ec_read/ec_write being obsolete and maybe provide a
solution for drivers who use those functions, as for example
sonypi.  Having two very same kind of access for the EC is
not good IMHO.

In fact why I didn't submitted this patch myself is because
I wanted to provide a real bus access via the EC driver, including
the interrupt driven ones.

Something like that :

int acpi_ec_register(struct acpi_ec_driver *child);
int acpi_ec_unregister(struct acpi_ec_driver *child);

The struct acpi_ec_driver should be something like that:

struct acpi_ec_driver {
	acpi_handle	ec_handle;
	acpi_handle	handle;
	unsigned long	uid;
	unsigned long	query;
	int (*acpi_ec_query_handler) (???);
	...
	/* maybe a private space somewhere */
	void *private;
}


reading/writing may pass perhaps via an exported acpi_ec_(read|write)()
functions, but the real key would have to be able to register a function
in order to trigger the acpi_ec_query_handler function member when the EC
receive the interrupt for the query number ->query instead of the _Qxx
method provided by the OEM.  Please look at ACPI 3.0 specification,
more precisely "5.6.2.2.2 Dispatching to an ACPI-aware Device Driver",
and the whole chapter 12 (ACPI Embedded Controller Interface Specification).

We may have then an access to the ACPI EC HC SMbus with a interrupt
driven driver, which imho is the correct approach: we will be sure
a _Qxx method provided by the bios writer will interferre with our
SMbus driver.

Unfortunately I don't have anymore the time to provide this support
for Linux.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
