From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 06/13] ACPI: updates rtc-cmos device platform_data
Date: Thu, 8 Feb 2007 22:02:51 -0800
Message-ID: <20070208220251.1cffe235.akpm@linux-foundation.org>
References: <200702060010.l160AEfC003735@shell0.pdx.osdl.net>
	<200702090056.02673.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:57461 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946135AbXBIGEM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Feb 2007 01:04:12 -0500
In-Reply-To: <200702090056.02673.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, david-b@pacbell.net, bjorn.helgaas@hp.com, dbrownell@users.sourceforge.net

On Fri, 9 Feb 2007 00:56:02 -0500 Len Brown <lenb@kernel.org> wrote:

> Okay, I acked this before, but I guess since it came back
> that you're looking for me to check it in and somebody else
> is handling the rest of your rtc patch series.
> 
> As it is ifdef'd so can't break anything if it goes in first...

yup, thanks - I queued this up as a non-acpi thing, to go in separately.

