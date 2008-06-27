From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] Fix pnpacpi_parse_irq_option()'s test against PNP_IRQ_NR
Date: Fri, 27 Jun 2008 15:38:45 +0200
Message-ID: <4864ED65.8050009@keyaccess.nl>
References: <4864E2B1.3040308@keyaccess.nl> <20080627123316.8122.15241.stgit@warthog.procyon.org.uk> <31574.1214572588@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:32966 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYF0NiF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jun 2008 09:38:05 -0400
In-Reply-To: <31574.1214572588@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: bjorn.helgaas@hp.com, rene.herman@gmail.com, len.brown@intel.com, linux-acpi@vger.kernel.org

On 27-06-08 15:16, David Howells wrote:

> Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> Pedantically, a simple unadorned int would be better it seems. The #define is
>> an int, __set_bit(_) takes an int and an int is printed.
> 
> Yes, but the test doesn't check for -ve values.  If it's unsigned, it doesn't
> need to.

Well, it's been promoted from a u8, so no need for that anyway, but <shrug>.

Rene.
