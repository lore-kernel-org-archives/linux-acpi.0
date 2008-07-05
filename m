From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 ACPI: Fix resume from suspend to RAM on
	uniprocessor x86-64
Date: Sat, 5 Jul 2008 08:44:04 +0200
Message-ID: <20080705064404.GB12991@elte.hu>
References: <200807050005.31272.rjw@sisk.pl> <200807050008.30497.Rafal.Wysocki@fuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:60792 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbYGEGoa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jul 2008 02:44:30 -0400
Content-Disposition: inline
In-Reply-To: <200807050008.30497.Rafal.Wysocki@fuw.edu.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Dionisus Torimens <djtm@gmx.net>


* R. J. Wysocki <Rafal.Wysocki@fuw.edu.pl> wrote:

> On Saturday, 5 of July 2008, Rafael J. Wysocki wrote:
> > Hi Ingo,
> > 
> > This is a regression fix, please push to Linus ASAP.

> Reported-by: Dionisus Torimens <djtm@gmx.net>

applied to tip/x86/urgent - thanks Rafael. I also queued up Peter's "x86 
ACPI: normalize segment descriptor register on resume" fix.

	Ingo
