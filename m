From: Andi Kleen <ak@suse.de>
Subject: Re: Linux does not correctly implement the ACPI specification
Date: 12 Apr 2006 18:56:35 +0200
Message-ID: <p73d5fm4trw.fsf@bragg.suse.de>
References: <971FCB6690CD0E4898387DBF7552B90E04970A19@orsmsx403.amr.corp.intel.com>
	<1144493556.8409.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:50383 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932206AbWDLQ4w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Apr 2006 12:56:52 -0400
In-Reply-To: <1144493556.8409.0.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Wainwright <prw@ceiriog.eclipse.co.uk>
Cc: linux-acpi@vger.kernel.org

Peter Wainwright <prw@ceiriog.eclipse.co.uk> writes:
> Instead of executing all the GPE and Notify handlers in the single
> kacpid thread, we create a pool of worker threads and hand over the
> work to them.

You do this at boot - this means you waste a lot of memory for this
obscure case. Not a good idea. If anything create/destroy them
dynamically.

Also externs belong in header files.

-Andi
