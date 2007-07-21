From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] hook acpi d-state to pnp suspend/resume
Date: Sat, 21 Jul 2007 12:38:02 -0700
Message-ID: <200707211238.03089.david-b@pacbell.net>
References: <1184897000.26022.17.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:21622 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758004AbXGUTk2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jul 2007 15:40:28 -0400
In-Reply-To: <1184897000.26022.17.camel@sli10-conroe.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>

On Thursday 19 July 2007, Shaohua Li wrote:
> 
> applied after Rafel's 'PM: Update global suspend and hibernation
> operations framework' patch set 
> 
> Hook acpi d-state to pnp suspend/resume.
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Looks about right, and I know the "punt to the PNP protocol
handler" approach will make Dmitry happy (for input devices);
it's very "hands-off".

How much has this been tested?  Have you verified that, for
example, PS/2 keyboards and mice now pay proper attention
to the driver model wakeup flags?

Unfortunately I don't have any system available for testing
this patch.

- Dave

