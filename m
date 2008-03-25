From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [RFC][PATCH] PM: Introduce new top level =?utf-8?q?suspend=09and_hibernation_callbacks?= (rev. 2)
Date: Tue, 25 Mar 2008 10:49:24 +0100
Message-ID: <200803251049.27696.oliver@neukum.org>
References: <200803210101.04706.rjw@sisk.pl> <1206058863.16475.165.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753770AbYCYJwb@vger.kernel.org>
In-Reply-To: <1206058863.16475.165.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Am Freitag, 21. M=C3=A4rz 2008 01:21:03 schrieb Johannes Berg:
> > + * All of the above callbacks, except for @complete(), return erro=
r codes.
> > + * However, the error codes returned by the resume operations, @re=
sume(),
> > + * @thaw(), and @restore(), are only printed in the system logs, s=
ince the PM
> > + * core cannot do anything else about them.
>=20
> Why bother and not just make them return void, the error printing can
> most likely be done much much better in the callback since that possi=
bly
> has information on why it failed.

A device that cannot wake up is unusable. Shouldn't the pm core disconn=
ect()
such a device?

	Regards
		Oliver
