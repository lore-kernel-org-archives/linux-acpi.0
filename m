From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Mon, 05 Oct 2009 02:56:55 +0400
Message-ID: <4AC92837.80708@suse.de>
References: <1254669853.26496.0.camel@carter> <200910042246.23712.rjw@sisk.pl> <4AC91578.2020807@suse.de> <200910050043.56667.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:46311 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756098AbZJDW5f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Oct 2009 18:57:35 -0400
In-Reply-To: <200910050043.56667.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Rafael J. Wysocki =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Sunday 04 October 2009, Alexey Starikovskiy wrote:
>> Hi Rafael,
>=20
> Alex,
>=20
>> This is not my rule, it was/is the rule of power device class. If yo=
u do not agree to it, please change
>> appropriate documentation.
>=20
> I think we're talking about two different things.  One thing is that =
we
> shouldn't put any _arbitrary_ interpretation rules into the kernel, w=
hich I
> agree with.  The other one is that if there's a _known_ _broken_ hard=
ware
> and one possible way of handling it is to add a quirk into the kernel=
, we
> should at least consider doing that.
>=20
> In my opinion adding a quirk for a broken hardware is not equivalent =
to
> "inferring not available properties using some heuristics or mathemat=
ical
> model", if that's what you're referring to.
No, this is not a clear "bug" and not a clear "fix". Please read my rep=
ly to Miguel.

>=20
> That said, the patch should not change the _default_ code in order to=
 handle
> the quirky hardware correctly.  IMO, the quirky hardware should be re=
cognized
It will change behaviour of at least Samsung notebooks, for which I per=
sonally saw the=20
charge_now/full_charge being greater then design_charge.
> during initialisation, if possible, and later handled in a special wa=
y.  If
> it's not possible to detect the broken hardware reliably, I agree tha=
t there's
> nothing we can do about that in the kernel.
I am still not sure if we have a broken hardware here.

Regards,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
