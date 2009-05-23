From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [RFC] why do we need run disk sync before entering?S3
Date: Sat, 23 May 2009 11:05:03 +0200
Message-ID: <200905231105.03828.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org> <200905230959.23018.oliver@neukum.org> <20090523085018.GA8782@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:60692 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbZEWJEk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 May 2009 05:04:40 -0400
In-Reply-To: <20090523085018.GA8782@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Am Samstag, 23. Mai 2009 10:50:18 schrieb Pavel Machek:
> On Sat 2009-05-23 09:59:22, Oliver Neukum wrote:
> > Am Freitag, 22. Mai 2009 17:33:57 schrieb Pavel Machek:
> > > > Take ACPI for example, ACPI defines two ACPI battery states, one is
> > > > "low" and another is "critical".
> > > > OS enters S3/S4 when battery is low, while it performs an emergency
> > > > shutdown when battery is in critical state. (ACPI spec 3.0b 3.9.4)
> > > > So I'm wondering if it's right to enter S3 when we know that the
> > > > system may lost power at anytime.
> > >
> > > Well, battery only lasts like 30 hours in S3. So if you leave your
> > > notebook unattended for 30 hours, you'll loose recent changes.
> >
> > Even if the battery is very low you get 30 hours?
>
> That will of course be less. 30 hours is really best case, on "good"
> notebook.
>
> What I was trying to point out is that even if you go into s3 with
> machine fully charged, you'll loose your data after like 30 hours.
> 									Pavel

Hi,

OK, I see so this was an argument for syncing. Sorry for misunderstanding.
But we'd still loose RAM. Which makes me wonder whether S3 and STD
really need to be mutually exclusive. Couldn't we write a snapshot to disk
just in case. All it would take is the STR code to mark the snapshot invalid
before any alteration of the filesystems.

	Regards
		Oliver


