From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/4] x86: Remove obsolete PM definitions from NMI header
Date: Thu, 12 Jun 2008 11:15:32 +0200
Message-ID: <20080612091532.GC15312@elte.hu>
References: <200806121025.24668.rjw@sisk.pl> <200806121027.09085.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:60586 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754025AbYFLJQN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Jun 2008 05:16:13 -0400
Content-Disposition: inline
In-Reply-To: <200806121027.09085.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Remove obsolete and no longer used PM-related definitions from 
> include/asm-x86/nmi.h .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

applied to tip/x86/cleanups, thanks Rafael.

	Ingo
