From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Intel Xeon 5649 2.53GHz Turbo problem
Date: Mon, 14 Nov 2011 01:29:28 -0200
Message-ID: <20111114032928.GA2360@khazad-dum.debian.net>
References: <4EC02231.9030501@itcare.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56488 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752025Ab1KND3d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Nov 2011 22:29:33 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1278520E96
	for <linux-acpi@vger.kernel.org>; Sun, 13 Nov 2011 22:29:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4EC02231.9030501@itcare.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Staszewski <pstaszewski@itcare.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sun, 13 Nov 2011, Pawe=C5=82 Staszewski wrote:
> How can I check if Turbo Boost is working with Xeon E5649
>=20
> I have turbostats that shows:
> pk cr CPU    %c0  GHz  TSC    %c1    %c3    %c6  %pc3  %pc6
>            56.12 2.67 2.53  43.88   0.00   0.00  0.00  0.00
                   ^^^^
It is working.

> So 2.67Ghz - but based on Intel spec max Turbo freq. for this cpu is =
2.93Ghz

You have too many cores active.  You'll have to quiesce 4 cores into C6
to get 2.93GHz[1] out of the remaining 2 cores in the package.

[1]
http://www.intel.de/content/dam/doc/specification-update/xeon-5600-spec=
ification-update.pdf

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
