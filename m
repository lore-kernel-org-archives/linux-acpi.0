From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before
 =?iso-8859-1?q?entering=09S3?=
Date: Sat, 23 May 2009 09:59:22 +0200
Message-ID: <200905230959.23018.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org> <1242631507.16529.107.camel@rzhang-dt> <20090522153356.GB27655@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:56238 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZEWING (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 May 2009 04:13:06 -0400
In-Reply-To: <20090522153356.GB27655@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Pavel Machek <pavel@ucw.cz>, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Am Freitag, 22. Mai 2009 17:33:57 schrieb Pavel Machek:
> > Take ACPI for example, ACPI defines two ACPI battery states, one is
> > "low" and another is "critical".
> > OS enters S3/S4 when battery is low, while it performs an emergency
> > shutdown when battery is in critical state. (ACPI spec 3.0b 3.9.4)
> > So I'm wondering if it's right to enter S3 when we know that the system
> > may lost power at anytime.
>
> Well, battery only lasts like 30 hours in S3. So if you leave your
> notebook unattended for 30 hours, you'll loose recent changes.

Even if the battery is very low you get 30 hours?

	Regards
		Oliver

