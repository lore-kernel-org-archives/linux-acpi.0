From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Sat, 31 Mar 2007 11:31:54 +0200
Message-ID: <200703311131.54704.ak@suse.de>
References: <460E0158.7090705@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:46847 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbXCaJcG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Mar 2007 05:32:06 -0400
In-Reply-To: <460E0158.7090705@goop.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Saturday 31 March 2007 08:36, Jeremy Fitzhardinge wrote:
> When I run 2.6.21-rc5 + Andi's x86 patches + paravirt_ops patches, I've
> been getting my machine shut down with critical thermal shutdown messages:

Hmm, don't think there's anything either in x86 that would touch this code.
But can you double check with plain rc5? 

> Mar 30 23:19:03 localhost kernel: ACPI: Critical trip point
> Mar 30 23:19:03 localhost kernel: Critical temperature reached (128 C), shutting down.
> Mar 30 23:19:03 localhost kernel: Critical temperature reached (128 C), shutting down.
> Mar 30 23:19:03 localhost shutdown[19417]: shutting down for system halt
> 
> and the machine does feel pretty hot.

Pavel has been complaining about higher power consumption on his laptop versus
.20 too.

-Andi
