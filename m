From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] Fix pnpacpi_parse_irq_option()'s test against PNP_IRQ_NR
Date: Fri, 27 Jun 2008 17:38:47 +0200
Message-ID: <48650987.7090103@keyaccess.nl>
References: <4864ED65.8050009@keyaccess.nl> <4864E2B1.3040308@keyaccess.nl> <20080627123316.8122.15241.stgit@warthog.procyon.org.uk> <31574.1214572588@redhat.com> <16399.1214578444@redhat.com> <486506A4.7060605@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:59799 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbYF0PiG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jun 2008 11:38:06 -0400
In-Reply-To: <486506A4.7060605@keyaccess.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: bjorn.helgaas@hp.com, rene.herman@gmail.com, len.brown@intel.com, linux-acpi@vger.kernel.org

On 27-06-08 17:26, Rene Herman wrote:

> On 27-06-08 16:54, David Howells wrote:
> 
>> Rene Herman <rene.herman@keyaccess.nl> wrote:
>> 
>>> Well, it's been promoted from a u8, so no need for that anyway,
>>> but <shrug>.
>> 
>> My logic is that in commit 95b24192cf27631dc11541e97c430389320e7a93
>> it says the following:
>> 
>> ACPI Extended Interrupt Descriptors can encode 32-bit interrupt 
>> numbers, so an interrupt number may exceed the size of the bitmap 
>> we use to track possible IRQ settings.
>> 
>> so the field in 'struct acpi_resource_irq' might at some point 
>> increase to be a 32-bit unsigned value.  Otherwise there's no point
>> having the check at all, right?

(as an aside, we conceptually don't know what PNP_IRQ_NR is -- why the 
define otherwise -- so the check in itself still makes some sense here 
as well).

> Ah, how lovely, there has been a merge error at some point...
> 
> No, that larger value would live in a struct acpi_resource_extended_irq. 
> This code was supposed to go in pnpacpi_parse_ext_irq_option() instead.
> 
> Here's the original posting of this patch:
> 
> http://lkml.org/lkml/2008/5/30/390
> 
> where it indeed is. Here is the last one, where it has mistakingly 
> shifted position to pnpacpi_parse_irq_option():
> 
> http://lkml.org/lkml/2008/6/17/337
> 
> I was already wondering why I hadn't see that warning myself while I was 
> testing things...
> 
> Bjorn?

Rene.
