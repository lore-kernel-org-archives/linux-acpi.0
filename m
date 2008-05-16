From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 07/11] acpi_pm_device_sleep_state() cleanup
Date: Fri, 16 May 2008 11:03:12 -0700
Message-ID: <200805161103.13871.jbarnes@virtuousgeek.org>
References: <200805142309.m4EN9KBX025994@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-03.bluehost.com ([69.89.21.13]:36594 "HELO
	outbound-mail-03.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759085AbYEPSKH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 May 2008 14:10:07 -0400
In-Reply-To: <200805142309.m4EN9KBX025994@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, dbrownell@users.sourceforge.net, bjorn.helgaas@hp.com, pavel@ucw.cz, trenn@suse.de

On Wednesday, May 14, 2008 4:09 pm akpm@linux-foundation.org wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
>
> Get rid of a superfluous acpi_pm_device_sleep_state() parameter.  The only
> legitimate value of that parameter must be derived from the first
> parameter, which is what all the callers already do.  (However, this does
> not address the fact that ACPI *still* doesn't set up those flags.)
>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Renninger <trenn@suse.de>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Looks good to me, should probably go in through the ACPI tree.

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
