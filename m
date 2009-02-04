From: Frank Seidel <fseidel@suse.de>
Subject: Re: [PATCH] ACPI: add missing KERN_* constants to printks
Date: Wed, 04 Feb 2009 16:31:11 +0100
Message-ID: <4989B4BF.6060509@suse.de>
References: <4989A784.3030604@suse.de> <200902041628.03675.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:59987 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbZBDPb2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Feb 2009 10:31:28 -0500
In-Reply-To: <200902041628.03675.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, len.brown@intel.com, shaohuhua.li@intel.com, kristen.c.accardi@intel.com, frank@f-seidel.de

Frans Pop wrote:
> This patch looks broken to me, at least for some of your changes.
> For example, in the bit quoted above all printks together make up
> *one single* message, which means that only the _first_ of the
> printks should have the KERN_* prefix. printks that are continuations
> should not have the prefix.

Are you absolutely sure about that? The janitors todo lets me guess
they should aswell me prefixed.
Otherwise yes, then some of the changes wouldn't be needed.

Thanks,
Frank
