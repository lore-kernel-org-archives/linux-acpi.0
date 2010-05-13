From: Andi Kleen <andi@halobates.de>
Subject: Re: [PATCH -v2 2/2] ACPI, APEI, EINJ injection parameters support
Date: Thu, 13 May 2010 11:04:45 +0200
Message-ID: <877hn8uq8i.fsf@basil.nowhere.org>
References: <1273716563-23573-1-git-send-email-ying.huang@intel.com>
	<1273716563-23573-3-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:57545 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757876Ab0EMJEu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 May 2010 05:04:50 -0400
In-Reply-To: <1273716563-23573-3-git-send-email-ying.huang@intel.com> (Huang Ying's message of "Thu\, 13 May 2010 10\:09\:23 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

Huang Ying <ying.huang@intel.com> writes:

> Some hardware error injection needs parameters, for example, it is
> useful to specify memory address and memory address mask for memory
> errors.
>
> Some BIOSes allow parameters to be specified via an unpublished
> extension. This patch adds support to it. The parameters will be
> ignored on machines without necessary BIOS support.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

Looks good. Len please add to the existing APEI queue.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
