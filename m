From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] ACPI: EC: Merge IRQ and POLL modes
Date: Sun, 30 Aug 2009 17:50:44 +0100
Message-ID: <9b2b86520908300950j40a62eaeqca28c7c5b1cd38b8@mail.gmail.com>
References: <20090829230613.15391.84344.stgit@thinkpad>
	 <alpine.LFD.2.00.0908292147590.15619@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:56721 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbZH3Qun (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sun, 30 Aug 2009 12:50:43 -0400
Received: by fxm17 with SMTP id 17so2376487fxm.37
        for <Linux-acpi@vger.kernel.org>; Sun, 30 Aug 2009 09:50:44 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908292147590.15619@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org

On 8/30/09, Len Brown <lenb@kernel.org> wrote:
> applied to acpi-test for 2.6.32

This passes my test for the temperamental Asus Eee 701. Thanks Alexey!
 Let's hope it works as well elsewhere.

I saw one hang on resume from hibernation while hammering the
brightness keys.  However  I can't reproduce it.  It might be a
regression, but it was probably just a fluke.

Alan
