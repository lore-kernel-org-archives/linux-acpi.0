From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 4/5] acpi: catch calls of acpi_driver_data on pointer of
 wrong type
Date: Thu, 9 Oct 2008 20:50:02 -0700
Message-ID: <20081009205002.15f90f63.akpm@linux-foundation.org>
References: <200809222137.m8MLbYdP031014@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41095 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752767AbYJJDuT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Oct 2008 23:50:19 -0400
In-Reply-To: <200809222137.m8MLbYdP031014@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, pavel@suse.cz, hare@suse.de

On Mon, 22 Sep 2008 14:37:34 -0700 akpm@linux-foundation.org wrote:

> From: Pavel Machek <pavel@suse.cz>
> 
> Catch attempts to use of acpi_driver_data on pointers of wrong type.
> 
> akpm: rewritten to use proper C typechecking and remove the
> "function"-used-as-lvalue thing.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Sent twice, no response, good patch, non-trivial maintenance load for me.

Merge, please?
