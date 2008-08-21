From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Thu, 21 Aug 2008 09:18:47 -0700
Message-ID: <20080821091847.0c6324c5.akpm@linux-foundation.org>
References: <200808202341.m7KNflv7005413@imap1.linux-foundation.org>
	<48AD5BBB.2050701@suse.de>
	<20080821122201.GA23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58564 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751063AbYHUQTr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Aug 2008 12:19:47 -0400
In-Reply-To: <20080821122201.GA23334@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

On Thu, 21 Aug 2008 14:22:01 +0200 Andi Kleen <andi@firstfloor.org> wrote:

> On Thu, Aug 21, 2008 at 04:12:43PM +0400, Alexey Starikovskiy wrote:
> > Hi Andrew,
> > 
> > As I understand, this patch is wrong according to comment #65 in bug #9998.
> 
> Ok I'll skip that one for now. Andrew can you please drop it.
> The bug will be handled in bugzilla.
> 

Not that I'm mistrustful or anything, but I think I'll hang onto it
until I'm told it got fixed..

http://bugzilla.kernel.org/show_bug.cgi?id=11089 is marked resolved,
and a duplicate of http://bugzilla.kernel.org/show_bug.cgi?id=10919,
which is marked resolved.  Is this all correct??
