From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2-UPDATE2 3/4] resource: Add device-managed
 insert/remove_resource()
Date: Tue, 08 Mar 2016 18:00:33 -0700
Message-ID: <1457485233.15454.530.camel@hpe.com>
References: <1457460530-17959-1-git-send-email-toshi.kani@hpe.com>
	 <CA+55aFy=V-esUXZa2AogS685k+r9PyyNStkZrrUUkWSKvLFUGQ@mail.gmail.com>
	 <CAPcyv4gT1RvnEquYXVo7sZscdUrkiWpG-Yvr_EX4=L25397X0g@mail.gmail.com>
	 <CA+55aFxPn3J68MsqQd7OVv7jetZjPduP53MFmw2f_-z7=ebpXQ@mail.gmail.com>
	 <CAPcyv4i2GwujqK=MDJpSKhvufJprmCV4vmQRpS_UP-n1kau+mg@mail.gmail.com>
	 <1457481844.15454.510.camel@hpe.com>
	 <CA+55aFxJqjvsSz7eeobViGShoJV=FSx9gDbxK_L0WvSnh3xa3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:57650 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbcCIAH6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2016 19:07:58 -0500
In-Reply-To: <CA+55aFxJqjvsSz7eeobViGShoJV=FSx9gDbxK_L0WvSnh3xa3w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2016-03-08 at 15:31 -0800, Linus Torvalds wrote:
> On Tue, Mar 8, 2016 at 4:04 PM, Toshi Kani <toshi.kani@hpe.com> wrote=
:
> >=20
> > Yes, I prefer the devm semantics.=C2=A0=C2=A0insert_resource() and
> > remove_resource() are not exported interfaces.=C2=A0=C2=A0So, with
> > devm_add_action(), we still need to introduce built-in exported
> > wrappers for insert/remove_resource(), unless we change to export t=
hem
> > directly.=C2=A0=C2=A0Since we need to export "something", I think i=
t is better to
> > export their devm interfaces.
>=20
> So I'm coming from the background that
>=20
> =C2=A0(a) less code is better
>=20
> =C2=A0(b) the "devm_" interface may be convenient, but it has also
> traditionally also been a cause of problems and limitations.
>=20
> Now, the main problems with the devm interface has been either
> ordering (which just isn't an issue with resource allocation - it's
> been an issue with irqs) or the fact that it can't always be used if
> you're not in the right context. So it's "convenient but potentially
> inflexible".
>=20
> And the thing is, I think convenience functions mainly make sense for
> places where there are multiple users. If there really is just one or
> two (number completely pulled out of my ass), I don't see the point o=
f
> a "convenience" function, when we've had the main actual _code_
> functionality for over a decade.
>=20
> So unless there are more users, I'd suggest just exporting the
> insert_resource function.
>=20
> We already export allocate_resource and adjust_resource.
>=20
> Now, the _one_ argument for devm_insert_resource() is that we do have
> "devm_request_resource()".
>=20
> But quite frankly, just counting the number of devm_request_resource(=
)
> calls weakens that argument. There's 7 callers in the whole kernel.
> The regular "request_resource()" has 200+ callers.
>=20
> That may be due to historical reasons, but it may also be at least
> partially due to (b) above - there are a number of cases where the
> "devm_xyz()" model doesn't work well.
>=20
> So I think we should see the "devm_xyz()" forms as being a "let's mak=
e
> things easy for driver writers". I do _not_ think it makes sense for
> one-off users.
>=20
> Now, if it turns out that there are lots of other potential users of
> devm_insert_resource(), that would maks all of my arguments go away.

I agree that there won't be many users of devm_insert_resource(). =C2=A0=
So, I am
going to export insert_resource() and remove_resource() as you suggeste=
d,
and let the NFIT driver to call them using devm_add_action() as a one-o=
ff
solution.

Thanks!
-Toshi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
