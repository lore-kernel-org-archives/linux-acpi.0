From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] Clear WAK_STS on resume
Date: Mon, 11 Aug 2008 13:25:15 +0200
Message-ID: <48A0219B.9070907@linux.intel.com>
References: <20080806175818.GA27134@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41253 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbYHKLZK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Aug 2008 07:25:10 -0400
In-Reply-To: <20080806175818.GA27134@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, pavel@suse.cz, rjw@sisk.pl

Matthew Garrett wrote:
> The leading other brand OS appears to clear the WAK_STS flag on resume. 
> When rebooted, certain BIOSes assume that the system is actually 
> resuming if it's still set and so fail to reboot correctly. Make sure 
> that it's cleared at resume time.

Queued for test thanks.

-Andi

