From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 2/2] ACPI/Wakup: Enable button wakeup GPEs if these GPEs have associated GPE methods.
Date: Wed, 09 Jul 2014 15:00:32 +0200
Message-ID: <1566864.H9h1bMoShf@vostro.rjw.lan>
References: <1404802679-24019-1-git-send-email-tianyu.lan@intel.com> <3011365.oYtXFx0LHa@vostro.rjw.lan> <53BCB23A.1070304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57041 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932094AbaGIMm1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2014 08:42:27 -0400
In-Reply-To: <53BCB23A.1070304@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, July 09, 2014 11:08:42 AM Lan Tianyu wrote:
> On 2014=E5=B9=B407=E6=9C=8808=E6=97=A5 21:26, Rafael J. Wysocki wrote=
:
> > On Tuesday, July 08, 2014 02:57:58 PM Lan Tianyu wrote:
> >> The button wakeup GPEs are enabled unconditionally in the current =
world by
> >> commit 2a5d24(ACPI / Wakeup: Enable button GPEs unconditionally du=
ring
> >> initialization). Because button's GPE methods needs to be run to c=
lear
> >> GPE status on some machines when there is GPE interrupt. If not, i=
t will
> >> cause machines resume immediately after being suspended since GPE =
status
> >> isn't cleared correctly.
> >>
> >> But if there is no GPE method for button wakeup GPE, these GPEs sh=
ould not
> >> be enabled since nothing needs to be done when they are triggered =
and this
> >> also causes LID GPE storm on Lenovo Ideapad y560p.
> >>
> >> This patch is to check Button GPE method and enable it if there is=
 associated
> >> GPE method.
> >=20
> > Part of the problem is that we call acpi_setup_gpe_for_wake() for b=
uttons too
> > and it sets ACPI_GPE_DISPATCH_NOTIFY unconditionally.
>=20
> Yes, this is why the GPE wasn't disabled by CA. From my opinion,
> original reason of enabling button wakeup GPE in the runtime is that =
it
> may have associated GPE method and the method will notify button driv=
er
> and clear some hardware status. But if it didn't have GPE method, I
> don't why we need to enable the GPE.

I think you're right, but "is there a handler method for that GPE prese=
nt?"
is a bit too low-level question to ask from outside of ACPICA.  We shou=
ld be
asking "is there any kind of handling registered for it?" if anything, =
but in
my opinion the cleanest approach would be to modify acpi_enable_gpe() t=
o
return an error code if there's no handler/method/notify for the GPE in
question.

The patch I attached to the BZ entry doesn't do that just yet, because =
I'm
wondering whether or not it will make the ACPICA's auto-disabling trigg=
er. :-)

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
