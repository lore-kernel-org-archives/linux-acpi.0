From: Matt Mackall <mpm@selenic.com>
Subject: Why is arch/x86/kernel/acpi/sleep.c:temp_stack 10k?
Date: Tue, 30 Sep 2008 19:12:37 -0500
Message-ID: <1222819957.13453.15.camel@calx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:45520 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbYJAAPA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Sep 2008 20:15:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

We've got:

#if defined(CONFIG_SMP) && defined(CONFIG_64BIT)
static char temp_stack[10240];
#endif

and:

#ifdef CONFIG_SMP
        stack_start.sp = temp_stack + 4096;
#endif

..which suggests we use at most 4k of the stack?

-- 
Mathematics is the supreme nostalgia of our time.

