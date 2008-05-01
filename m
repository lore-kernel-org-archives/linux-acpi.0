From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch 05/10] acpi: use __init* on everything in
	tables/tbfadt.c
Date: Thu, 01 May 2008 21:02:39 +0200
Message-ID: <1209668559.1131.65.camel@linux-2bdv.site>
References: <200805010952.m419q40A031809@imap1.linux-foundation.org>
	 <1209668151.1131.60.camel@linux-2bdv.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40986 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762722AbYEATCl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 May 2008 15:02:41 -0400
In-Reply-To: <1209668151.1131.60.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, akpm <akpm@linux-foundation.org>


On Thu, 2008-05-01 at 20:55 +0200, Thomas Renninger wrote:
> Andrew, IMO you can drop this and the const cleanups from -mm tree.
...
> __init does not exist there (yet).
...
I wonder whether Intel could already think about or implement a possible
__init integration. There is probably a lot more that can be declared
__init which can then be cleaned up by Linux kernel developers as soon
as acpica exists as repository. 

   Thomas

