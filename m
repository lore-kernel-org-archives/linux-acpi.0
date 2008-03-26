From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level
 =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Wed, 26 Mar 2008 12:36:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803261236080.7344-100000@iolanthe.rowland.org>
References: <200803261642.29801.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760640AbYCZQgs@vger.kernel.org>
In-Reply-To: <200803261642.29801.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 26 Mar 2008, Oliver Neukum wrote:

> Am Mittwoch, 26. M=E4rz 2008 15:40:27 schrieb Alan Stern:
> > Remember, the whole purpose of this is to let drivers know when the=
=20
> > system is going to sleep or waking up. =A0Proper handling of device=
s is=20
> > up to the drivers, not up to the core.
>=20
> Then declare these methods void. We cannot introduce methods that del=
iberately
> ignore errors. Reporting is also better done in the drivers.

That decision is up to Rafael.  Changing the methods to return void is=20
okay with me.

Alan Stern
