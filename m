From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation callbacks (highest level) - updated
Date: Wed, 12 Mar 2008 01:37:24 -0800
Message-ID: <200803120237.24857.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0803092219290.31643-100000@netrider.rowland.org> <200803101758.01826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:30787 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750987AbYCLJha (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 05:37:30 -0400
In-Reply-To: <200803101758.01826.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>

On Monday 10 March 2008, Rafael J. Wysocki wrote:
> + * @poweroff: Hibernation-specific, executed after saving a hibernat=
ion image.
> + *=A0=A0=A0=A0=A0Quiesce the device, put it into a low power state a=
ppropriate for the
> + *=A0=A0=A0=A0=A0upcoming system state (such as PCI_D3hot), and enab=
le wakeup events as
> + *=A0=A0=A0=A0=A0appropriate.

This seems uncomfortably similar to device_driver.shutdown().
The only obvious difference is wakeup event handling, and even
that is already a function of the target system state.

Are both methods needed?

Shouldn't this be more generic, not "hibernation-specific"?

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
