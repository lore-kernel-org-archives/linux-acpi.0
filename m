From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume (updated)
Date: Wed, 19 Aug 2009 10:07:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908191004560.3001-100000@iolanthe.rowland.org>
References: <200908190033.23502.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48080 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751974AbZHSOHa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Aug 2009 10:07:30 -0400
In-Reply-To: <200908190033.23502.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>

On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:

> There's a problem that for safety reasons I maintain the ordering of dpm_list
> and the callbacks are scheduled for async execution in the same order in
> which they would have been executed synchronously.  If were to change this,
> we'd have to be _very_ careful.

Why?  The order in which jobs are scheduled for async execution doesn't 
bear any particular relation to the order in which they get run.

Alan Stern

