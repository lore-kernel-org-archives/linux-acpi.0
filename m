From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: [ltp] ACPI suspend works once, then fails. (A22p)
Date: Fri, 4 Aug 2006 09:07:32 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1F85E56@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12311 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751410AbWHDBHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 21:07:46 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-acpi@vger.kernel.org

=20
Please try patch at http://bugzilla.kernel.org/show_bug.cgi?id=3D6749#c=
8

-----Original Message-----
=46rom: linux-thinkpad-admin@linux-thinkpad.org [mailto:linux-thinkpad-=
admin@linux-thinkpad.org] On Behalf Of Daniel Maier
Sent: 2006=C4=EA8=D4=C24=C8=D5 4:40
To: linux-thinkpad@linux-thinkpad.org
Subject: Re: [ltp] ACPI suspend works once, then fails. (A22p)

On Thu, Aug 03, 2006 at 07:39:42AM +0100, Richard Neill wrote:
>=20
> I've repeated this multiple times, with different kernels (2.6.16.20 =
and=20
> 2.6.17.7). Each time, the first suspend-resume cycle is perfectly OK,=
=20
>
I have a similiar problem with all kernels after 2.6.15.7, so you
might want to try a 2.6.15.

Regards, nusse.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
