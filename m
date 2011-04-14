From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [RFC 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Thu, 14 Apr 2011 11:40:57 +0200
Message-ID: <4DA6C129.8010001@suse.cz>
References: <4C87A62E.30108@gmail.com> <1302598086-3622-1-git-send-email-jslaby@suse.cz> <20110412085622.43488ed9@jbarnes-desktop> <20110412155921.GA531@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33734 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757284Ab1DNJlF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Apr 2011 05:41:05 -0400
In-Reply-To: <20110412155921.GA531@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, jirislaby@gmail.com, Robert Hancock <hancockrwd@gmail.com>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/12/2011 05:59 PM, Matthew Garrett wrote:
> On Tue, Apr 12, 2011 at 08:56:22AM -0700, Jesse Barnes wrote:
> 
>> I'll defer to the ACPI experts, Len or Matthew have you checked this
>> one out?
> 
> Windows appears to work without this, so it seems likely that we're 
> doing something wrong in some other sense, but I don't think we have a 
> good idea as to what we're doing wrong...

Is there anything I can do about that? Provide some info, investigate
what a particular code does in the kernel (e.g. acpi_pci_irq_enable) etc.?

thanks,
-- 
js
suse labs
