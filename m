From: Andrew Morton <akpm@linux-foundation.org>
Subject: acpi_bus_generate_genetlink_event
Date: Thu, 19 Jul 2007 13:25:56 -0700
Message-ID: <20070719132556.a3fe2303.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60294 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754735AbXGSU0b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jul 2007 16:26:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org


It's quite sad that this uses GFP_ATOMIC.  Because GFP_ATOMIC is quite
unreliable.

Is it just not possible to use GFP_KERNEL here? 

If _any_ of the callers of this function could have used GFP_KERNEL then we
could at least pass the gfp_t into this function to allow it to use the
stronger form where it can do so.

