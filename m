From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] Create sony-laptop
Date: Thu, 8 Feb 2007 01:04:49 -0800
Message-ID: <20070208010449.d8be1234.akpm@linux-foundation.org>
References: <11708749163025-git-send-email-malattia@linux.it>
	<11708749161009-git-send-email-malattia@linux.it>
	<200702071550.35808.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34257 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423110AbXBHJGU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Feb 2007 04:06:20 -0500
In-Reply-To: <200702071550.35808.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: malattia@linux.it, linux-acpi@vger.kernel.org

On Wed, 7 Feb 2007 15:50:35 -0500 Len Brown <lenb@kernel.org> wrote:

> Finally, I don't have a Sony laptop so I can't test this.
> I'd like to see successful test feedback from Andrew,
> Luming, and other Sony owners before we push it.

Seems to work.  At least, I can still alter the brightness - I've never
worked out how to get that driver to do anything else.

The sony-laptop module doesn't get loaded at boot (FC5).  Should it?

I always get asus_acpi loaded, even on the x86_64 server.  I want some of
that on the sony ;)

