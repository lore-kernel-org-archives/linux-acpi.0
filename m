From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for linus tree] ACPI: remove duplicated lines of merging
 problems with acpi_processor_add
Date: Tue, 7 Feb 2012 09:45:29 -0800
Message-ID: <CA+55aFyXfFQg3QELyvE+WgbZ3g+FB2KLf5pMebTJ-b5L8Tee6A@mail.gmail.com>
References: <1328631637-9488-1-git-send-email-yinghai@kernel.org> <1328631637-9488-2-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59711 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2BGRpu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2012 12:45:50 -0500
Received: by pbcun15 with SMTP id un15so18237pbc.19
        for <linux-acpi@vger.kernel.org>; Tue, 07 Feb 2012 09:45:50 -0800 (PST)
In-Reply-To: <1328631637-9488-2-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

On Tue, Feb 7, 2012 at 8:20 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> Those lines have two copies.
>
> Not sure how it could happen, looks like git problem.

Looks more like somebody just applied the same patch twice, or just
cut-and-pasted a few too many times.

                     Linus
