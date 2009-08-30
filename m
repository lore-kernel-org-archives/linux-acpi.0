From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] ACPI: Clarify resource conflict message
Date: Sun, 30 Aug 2009 22:10:50 +0100
Message-ID: <9b2b86520908301410i31b69f71s27809788d3b1f103@mail.gmail.com>
References: <200908301546.22827.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:35031 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZH3VKt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Aug 2009 17:10:49 -0400
Received: by fxm17 with SMTP id 17so2447661fxm.37
        for <linux-acpi@vger.kernel.org>; Sun, 30 Aug 2009 14:10:51 -0700 (PDT)
In-Reply-To: <200908301546.22827.jdelvare@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, Thomas Renninger <trenn@suse.de>

On 8/30/09, Jean Delvare <jdelvare@suse.de> wrote:
> The message "ACPI: Device needs an ACPI driver" is misleading. The
> device _may_ need an ACPI driver, if the BIOS implemented an API for
> the device in question (which, AFAIK, can't be checked.) If not, then
> either the generic "thermal" ACPI driver may be used,

Um, the 'generic "thermal" ACPI driver' counts as 'an ACPI driver' :-).

> or nothing can
> be done (other than a white list, if we really want to get hardware
> monitoring on some machines.)

Fair point.  I don't like the message either.  "needs" seems quite a
demanding word to me.  Personally I'd be happy with just the conflict
message which precedes it.

> I propose to reword the message to:
>
> ACPI: Device may still be supported by an ACPI driver
>
> which I think is more correct. Comments and suggestions welcome.

I would drop the word "still", but otherwise I think this is a good idea.

Regards
Alan
