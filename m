From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other GPEs) on Asus EeePC
Date: Thu, 21 Aug 2008 14:22:01 +0200
Message-ID: <20080821122201.GA23334@one.firstfloor.org>
References: <200808202341.m7KNflv7005413@imap1.linux-foundation.org> <48AD5BBB.2050701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:49922 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYHUMUF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 08:20:05 -0400
Content-Disposition: inline
In-Reply-To: <48AD5BBB.2050701@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: akpm@linux-foundation.org, andi@firstfloor.org, linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

On Thu, Aug 21, 2008 at 04:12:43PM +0400, Alexey Starikovskiy wrote:
> Hi Andrew,
> 
> As I understand, this patch is wrong according to comment #65 in bug #9998.

Ok I'll skip that one for now. Andrew can you please drop it.
The bug will be handled in bugzilla.

-Andi
