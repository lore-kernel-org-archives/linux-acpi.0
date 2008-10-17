From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 ACPI: Fix breakage of resume on 64-bit UP systems
	with SMP kernel
Date: Fri, 17 Oct 2008 14:20:06 +0200
Message-ID: <20081017122006.GA25285@elte.hu>
References: <200810170126.27890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41646 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbYJQMU2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Oct 2008 08:20:28 -0400
Content-Disposition: inline
In-Reply-To: <200810170126.27890.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> x86 ACPI: Fix breakage of resume on 64-bit UP systems with SMP kernel

applied to tip/x86/urgent, with a stable@kernel.org tag - thanks Rafael!

	Ingo
