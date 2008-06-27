From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Fix pnpacpi_parse_irq_option()'s test against PNP_IRQ_NR
Date: Fri, 27 Jun 2008 14:16:28 +0100
Message-ID: <31574.1214572588@redhat.com>
References: <4864E2B1.3040308@keyaccess.nl> <20080627123316.8122.15241.stgit@warthog.procyon.org.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50575 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbYF0NQp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jun 2008 09:16:45 -0400
In-Reply-To: <4864E2B1.3040308@keyaccess.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: dhowells@redhat.com, bjorn.helgaas@hp.com, rene.herman@gmail.com, len.brown@intel.com, linux-acpi@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> wrote:

> Pedantically, a simple unadorned int would be better it seems. The #define is
> an int, __set_bit(_) takes an int and an int is printed.

Yes, but the test doesn't check for -ve values.  If it's unsigned, it doesn't
need to.

> Hyper-pedantically, this adds one space too many :-)

Bah.

David
