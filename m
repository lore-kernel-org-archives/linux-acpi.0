From: Len Brown <lenb@kernel.org>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Mon, 7 Jan 2008 14:12:59 -0500
Message-ID: <200801071412.59964.lenb@kernel.org>
References: <20071130142058.816d1693.akpm@linux-foundation.org> <20080106231848.762e93c1.akpm@linux-foundation.org> <4782400D.2040802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57388 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbYAGTOF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jan 2008 14:14:05 -0500
In-Reply-To: <4782400D.2040802@rtr.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Arjan van de Ven <arjan@infradead.org>, abelay@novell.com, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl

1. Why does VMware need max_cstate=1 to load quickly?
   It should not, and the fact that it does means
   that something somewhere is seriously broken.

2. Why does the "max_csate=1" workaround help only
   on the dual-core boxes, while the single-core
   boxes still fail to load quickly?

I'm glad that we deleted run-time access to max_cstate --
it seems to have exposed a real bug that needs fixing
and has gone unreported until now.

Indeed, when the real bug is fixed, I propose that
we again move to delete max_cstate as a run-time API.

-Len
