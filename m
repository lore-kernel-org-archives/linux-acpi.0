From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] ACPI: Fix typo in "Disable MWAIT via DMI on broken Compal board"
Date: Thu, 21 Aug 2008 08:44:04 +0200
Message-ID: <87abf6n9zf.fsf@basil.nowhere.org>
References: <e678b6ed0808200744k14429ab4sf8e636d0a97ca2e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56751 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639AbYHUGoH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 02:44:07 -0400
In-Reply-To: <e678b6ed0808200744k14429ab4sf8e636d0a97ca2e4@mail.gmail.com> (Dennis Jansen's message of "Wed, 20 Aug 2008 16:44:03 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: d.g.jansen@googlemail.com
Cc: linux-acpi@vger.kernel.org

"Dennis Jansen" <Dennis.Jansen@web.de> writes:

> This fixes a typo in commit 2a2a64714d9c40f7705c4de1e79a5b855c7211a9
> "Disable MWAIT via DMI on broken Compal board".
>
> It allows the nomwait dmi check to actually detect the Acer 5220.

Queued for 2.6.27 thanks. The patch was word-wrapped, please see
Documentation/email-clients.txt on how to avoid it in the future.
I fixed it up for now.

-Andi
