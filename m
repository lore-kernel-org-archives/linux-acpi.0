From: Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Completely discharging LION batteries
Date: Thu, 12 Dec 2002 12:22:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212121222.43960.jbr.1@gmx.net>
References: <B900970C7DD9474C972986EB3EC7C58F04EA7D@andromeda.agcad.local> <E18MAH1-0000WG-00@noys.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E18MAH1-0000WG-00-Hkr6DilkjYZTIIw02KIYYwp9XTrnmqkB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > > I'm using Linux 2.4.20 together with the acpi patches
> > > 20021205-2.4.20 on a
> > > Thinkpad T20. If I use two batteries (the builtin and a
> > > second in the Ultra-
> > > Bay), the second battery first gets discharged _completely_
> > > and after that the internal battery is used.
> >
> > That's normal, but yes it is not the smartest idea to do.
>
> What I'm wondering about is that in the Windows 2000 Help of
> the Thinkpad Laptop, IBM advises that it is better to discharge
> the battery sometimes completely to refresh the full capacity
> at least partly. That advise is completely the opposite of what
> I've seen. But it could be an mistake in their documentation or
> they could target NiMH batteries.

Interesting informations about Li-ion batteries can be found at 
http://www.buchmann.ca/. It seems to be not available at the moment. But here 
are a few tips from the page:

- Charge the Li-ion often, except before a long storage. Avoid repeated deep
  discharges.
- Keep the Li-ion battery cool. Prevent storage in a hot car. Never freeze a
  battery. 
- If your laptop is capable of running without a battery and fixed power is
  used most of the time, remove the battery and store it in a cool place. 
- Avoid purchasing spare Li-ion batteries for later use. Observe manufacturing
  date when purchasing. Do not buy old stock, even if sold at clearance
  prices.

But there is also a note on the site that a deep discharge cannot bring back I 
higher full charge level. On this list I once found the tip that it should
work. I tried it and my battery was again able to charge to full capacity.
btw: DO NEVER COMPLETELY DISCHARGE A LI-ION! Normal electronic devices can not 
discharge a Li-ion completely. So it should be ok to discharge until the 
device powers of. There is still enough power in the battery to lit a lamp 
for a long time. But that would discharge it definitively to low!

Jochen


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
