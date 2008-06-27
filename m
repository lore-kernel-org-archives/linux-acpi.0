From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Fix pnpacpi_parse_irq_option()'s test against PNP_IRQ_NR
Date: Fri, 27 Jun 2008 15:54:04 +0100
Message-ID: <16399.1214578444@redhat.com>
References: <4864ED65.8050009@keyaccess.nl> <4864E2B1.3040308@keyaccess.nl> <20080627123316.8122.15241.stgit@warthog.procyon.org.uk> <31574.1214572588@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756196AbYF0OyR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jun 2008 10:54:17 -0400
In-Reply-To: <4864ED65.8050009@keyaccess.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: dhowells@redhat.com, bjorn.helgaas@hp.com, rene.herman@gmail.com, len.brown@intel.com, linux-acpi@vger.kernel.org


Rene Herman <rene.herman@keyaccess.nl> wrote:

> Well, it's been promoted from a u8, so no need for that anyway, but <shrug>.

My logic is that in commit 95b24192cf27631dc11541e97c430389320e7a93 it says
the following:

	ACPI Extended Interrupt Descriptors can encode 32-bit interrupt
	numbers, so an interrupt number may exceed the size of the bitmap
	we use to track possible IRQ settings.
 
so the field in 'struct acpi_resource_irq' might at some point increase to be
a 32-bit unsigned value.  Otherwise there's no point having the check at all,
right?

David
