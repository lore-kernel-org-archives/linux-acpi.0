From: Matthew Garrett <mjg@redhat.com>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 16:42:47 +0000
Message-ID: <20081206164247.GD7623@srcf.ucam.org>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <200812061426.08294.mheinz@cs.uni-frankfurt.de> <20081206162649.GA7623@srcf.ucam.org> <200812061733.37471.mheinz@cs.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35986 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbYLFQmu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 11:42:50 -0500
Content-Disposition: inline
In-Reply-To: <200812061733.37471.mheinz@cs.uni-frankfurt.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Cc: linux-acpi@vger.kernel.org

On Sat, Dec 06, 2008 at 05:33:36PM +0100, Matthias Heinz wrote:

> f0: 09 08 34 07 ff 00 00 00 a0 0f 07 00 20 10 b6 bd
                                          ^^^^^^^^^^^
Ok, that indicates that your system claims opregion support, which would 
explain the difference in behaviour since 2.6.26.

> Interrupt enable:    00000053
> Interrupt identity:  00000000
> Interrupt mask:      fffedfae
> Pipe A stat:         00040000
> Pipe B stat:         00400206

And this indicates that there's a legacy backlight control event waiting 
to be handled, but no interrupt appears to have been raised. Does 
hitting the brightness key result in "Interrupts received" changing?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
