From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] ACPI: add DMI info to enable OSI(Linux) on
 PRIMEQUEST
Date: Tue, 27 May 2008 16:50:43 -0700
Message-ID: <20080527165043.6522f061.akpm@linux-foundation.org>
References: <4816F9B9.3090609@jp.fujitsu.com>
	<4836660B.3080406@jp.fujitsu.com>
	<483667A4.9000606@jp.fujitsu.com>
	<20080527162029.e549a226.akpm@linux-foundation.org>
	<12c511ca0805271641r68d50d3do9f6427a8dc6ad469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58802 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759297AbYE0Xuq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 May 2008 19:50:46 -0400
In-Reply-To: <12c511ca0805271641r68d50d3do9f6427a8dc6ad469@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 27 May 2008 16:41:59 -0700
"Tony Luck" <tony.luck@intel.com> wrote:

> I'm not sure that sharing drivers/acpi/blacklist.c between different
> architectures is wise idea.  There are entries in there that make
> blanket decisions for all machines made by an OEM.
> 
> It seems quite possible that an OEM that makes boxes using
> different processor architectures might make different mistakes
> in the respective BIOS teams.
> 

So...  what's the fix?  We don't appear to have a blacklisting table
under arch/ia64.  Should `#ifdef CONFIG_IA64' be added to
drivers/acpi/blacklist.c entries?
