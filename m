From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI Warning (nspredef-0858): \_SB_.BAT0._BIF: Return Package
	type mismatch at index 9
Date: Thu, 20 Nov 2008 09:32:36 +0800
Message-ID: <1227144756.15014.269.camel@rzhang-dt>
References: <492493FD.7020501@freemail.hu>
	 <1227142788.15014.260.camel@rzhang-dt>  <4924B89A.9080000@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26456 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbYKTBdF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Nov 2008 20:33:05 -0500
In-Reply-To: <4924B89A.9080000@freemail.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

this is a duplicate of bug
http://bugzilla.kernel.org/show_bug.cgi?id=3D11822
patch is attached just now, please give it a try. :)

thanks,
rui

On Thu, 2008-11-20 at 09:08 +0800, N=C3=A9meth M=C3=A1rton wrote:
> Here you are.
>=20
> Zhang Rui wrote:
> > Please attach the acpidump output.
> > you can use the latest pmtools here:
> > http://www.lesswatts.org/downloads/#acpi
> >=20
> > thanks,
> > rui
> >=20
> > On Thu, 2008-11-20 at 06:32 +0800, N=C3=A9meth M=C3=A1rton wrote:
> >> Hi,
> >>
> >> I am running Linux kernel 2.6.28-rc5. I get the following warning =
message
> >> during boot in dmesg:
> >>
> >> [   21.425678] ACPI Warning (nspredef-0858): \_SB_.BAT0._BIF: Retu=
rn Package type mismatch at index 9 - found Buffer, expected String [20=
080926]
> >>
> >> What does it mean? Is it a serious problem?
> >>
> >> The laptop is a Clevo D410J. The dmesg attached.
> >>
> >> Regards,
> >>
> >> 	M=C3=A1rton N=C3=A9meth
> >>
> >=20
> >=20
> >=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
