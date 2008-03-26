From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level =?iso-8859-1?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Wed, 26 Mar 2008 21:46:38 +0100
Message-ID: <200803262146.39899.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803261236080.7344-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760723AbYCZUr5@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0803261236080.7344-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, 26 of March 2008, Alan Stern wrote:
> On Wed, 26 Mar 2008, Oliver Neukum wrote:
>=20
> > Am Mittwoch, 26. M=E4rz 2008 15:40:27 schrieb Alan Stern:
> > > Remember, the whole purpose of this is to let drivers know when t=
he=20
> > > system is going to sleep or waking up. =A0Proper handling of devi=
ces is=20
> > > up to the drivers, not up to the core.
> >=20
> > Then declare these methods void. We cannot introduce methods that d=
eliberately
> > ignore errors. Reporting is also better done in the drivers.
>=20
> That decision is up to Rafael.  Changing the methods to return void i=
s=20
> okay with me.

But that's not what they currently do, either.

If I change the methods to void and it turns out in the future that it'=
s
better if they return error codes, it will be rather difficult to go ba=
ck and
change everything.  For this reason, I'd prefer to retain the returning=
 of
error codes.

What exactly do you whink would be wrong with using the error codes to =
avoid
resuming the children of devices that failed to resume?

Rafael
