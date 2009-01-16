From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI suspend: Fix compilation warnings in
 drivers/acpi/sleep.c
Date: Fri, 16 Jan 2009 14:49:33 -0800
Message-ID: <20090116144933.3ed476f9.akpm@linux-foundation.org>
References: <200901162309.14778.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49284 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756085AbZAPWuV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Jan 2009 17:50:21 -0500
In-Reply-To: <200901162309.14778.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 16 Jan 2009 23:09:14 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Fix two compilation warnings in drivers/acpi/sleep.c, one triggered
> by unsetting CONFIG_SUSPEND and the other triggered by unsetting
> CONFIG_HIBERNATION, by moving some code under the appropriate
> #ifdefs .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/x86/kernel/acpi/sleep.c |    4 +--
>  drivers/acpi/sleep.c         |   51 +++++++++++++++++++++----------------------

Confused.  drivers/acpi/sleep.c was removed six years ago?
