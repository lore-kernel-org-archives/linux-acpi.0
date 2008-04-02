From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 6)
Date: Wed, 2 Apr 2008 17:28:44 +0200
Message-ID: <200804021728.45823.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0804021104190.6272-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757899AbYDBP3E@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0804021104190.6272-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-acpi@vger.kernel.org

Am Mittwoch, 2. April 2008 17:13:11 schrieb Alan Stern:
> Basically yes. =A0Subsystems and drivers are allowed to keep devices
> suspended if they were suspended before the system went to sleep. =A0
> Remember, the purpose of the resume method is to let drivers know tha=
t
> the system is now awake, not to force them to put their devices into =
a
> high-power state.

Well, sometimes it is exactly that what we desire, eg. as a side effect
of lsusb. Should the callbacks have different semantics depending on
the reason you call them? And how should that information be transferre=
d?

	Regards
		Oliver
