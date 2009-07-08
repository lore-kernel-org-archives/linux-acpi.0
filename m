From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for run-time PM of
 I/O  devices (rev. 8)
Date: Wed, 8 Jul 2009 10:26:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907081022250.2867-100000@iolanthe.rowland.org>
References: <aec7e5c30907072140y7dd3b4c7ge7cb0b750bef3226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:58291 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754010AbZGHO06 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2009 10:26:58 -0400
In-Reply-To: <aec7e5c30907072140y7dd3b4c7ge7cb0b750bef3226@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>

On Wed, 8 Jul 2009, Magnus Damm wrote:

> >> > All good with the code above, but there seem to be some issue wi=
th how
> >> > usage_count is counted up and down and when runtime_disabled is =
set:
> >> >
> >> > 1. pm_runtime_init(): usage_count =3D 1, runtime_disabled =3D tr=
ue
> >> > 2. driver_probe_device(): pm_runtime_get_sync()
> >> > 3. pm_runtime_get_sync(): usage_count =3D 2
> >> > 4. device driver probe(): pm_runtime_enable()
> >> > 5. pm_runtime_enable(): usage_count =3D 1
> >> > 6. driver_probe_device(): pm_runtime_put()
> >> > 7. pm_runtime_put(): usage_count =3D 0
> >> >
> >> > I expect runtime_disabled =3D false in 7.
> >
> > Wasn't it? =A0It should have been set to false in step 4 and remain=
ed
> > that way.
>=20
> I may misunderstand, but in v8 won't the pm_runtime_enable() function
> do a atomic_dec_test() where the counter value will go from 2 to 1 in
> the case above? This would mean that atomic_dec_test() returns false
> so runtime_disabled is never modified.

There still hasn't been any time for me to look through the code.  It=20
sounds like Rafael was trying to use one counter for two separate=20
purposes.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
