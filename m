From: Andi Kleen <ak@suse.de>
Subject: Re: ASUS P5W DH boot up messages
Date: Fri, 16 Feb 2007 19:45:47 +0100
Message-ID: <200702161945.47922.ak@suse.de>
References: <20070216104332.2a5f1768@freekitty>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38061 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946219AbXBPSqA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 13:46:00 -0500
In-Reply-To: <20070216104332.2a5f1768@freekitty>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Friday 16 February 2007 19:43, Stephen Hemminger wrote:

> 1. Some noise about E820 mapping
> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> 
> 2. Doesn't use MMCONFIG
> PCI: Not using MMCONFIG.

Asus gets MCFG wrong in most older BIOSes. We finally decided to not try to fix
it up, but just reject them.

-Andi
