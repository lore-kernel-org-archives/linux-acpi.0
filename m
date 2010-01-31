From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [RFC][RFT][PATCH] ACPI: Protection from suspending in the middle
	of EC transaction
Date: Sun, 31 Jan 2010 14:11:21 +0000
Message-ID: <9b2b86521001310611m339862afw73410dc7eb5692c8@mail.gmail.com>
References: <201001310029.48717.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:53659 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab0AaOLX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Jan 2010 09:11:23 -0500
In-Reply-To: <201001310029.48717.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>

On 1/30/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> While Maxim is testing if the patch below helps with
> http://bugzilla.kernel.org/show_bug.cgi?id=14668
> I think it's necessary anyway.
>
> The problem is that currently there's nothing to prevent us from suspending
> in
> the middle of an EC transaction in progress, at least as far as I can see.
> As a result, we can suspend with the ACPI global lock held or something like
> this, which leads to problems especially for hibernation (if the resume
> kernel
> passes control to the image kernel in the middle of an EC transaction,
> things
> aren't nice).  For this reason I think we should wait until there are no EC
> transactions in progress before we suspend and we should prevent any new
> EC transactions from starting after that point.  The patch below does that.

I also believe this is a problem.  I reported the following -

<http://bugzilla.kernel.org/show_bug.cgi?id=14112> "Pressing acpi
hotkeys duing hibernation may occasionally cause EC transaction
timeout"

and posted a patch, but I couldn't reproduce my specific issue in
order to confirm that the patch helped.

Regards
Alan
