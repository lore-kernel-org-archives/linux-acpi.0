From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 1/4] acpi: enable C3 Power State on Dell Inspiron 8200
Date: Sun, 06 Jul 2008 20:43:32 +0200
Message-ID: <48711254.4080503@firstfloor.org>
References: <200807040705.m6475R65018507@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:38406 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbYGFSnf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jul 2008 14:43:35 -0400
In-Reply-To: <200807040705.m6475R65018507@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, dag@bakke.com, arjan@infradead.org, lenb@kernel.org

akpm@linux-foundation.org wrote:
> From: Dag Bakke <dag@bakke.com>
> 
> Taken from http://bugzilla.kernel.org/show_bug.cgi?id=8703

NAK.

Len's latest reply in bugzilla was

>>>
Dell replied off-line that they disabled C3 on this system on purpose
because of its chipset.

If you are able to measure a power savings by 2nd guessing Dell,
without any stability problems, then please document that here
and re-open this sighting.
<<<

I agree with him. The BIOS likely knows better on this

Andrew, please drop the patch.

-Andi

