From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 22:41:08 +0200
Message-ID: <200804142241.11545.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0804141043001.2236-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:34210 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbYDNUln convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Apr 2008 16:41:43 -0400
In-Reply-To: <Pine.LNX.4.44L0.0804141043001.2236-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>

Am Montag, 14. April 2008 16:49:26 schrieb Alan Stern:
> Now, I don't see what the big deal is here. =A0We all agree that it w=
ould=20
> be nice and appropriate if drivers could do things like=20
> request_firmware() during prepare(). =A0But for the moment they can't=
=2E =A0
> It's not like this is some tremendous hardship -- you aren't going to=
=20
> have to rip out all the existing prepare() implementations and rewrit=
e=20
> them, because they don't exist yet!

True. You cannot request firmware in the current suspend() call either.
Rafael's code is a clear improvement over the existing code. Removal
of the freezer will need a lot of rewriting in any case.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
