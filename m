From: "Renato S. Yamane" <yamane@diamondcut.com.br>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Tue, 15 Jul 2008 08:13:32 -0300
Message-ID: <487C865C.5060303@diamondcut.com.br>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com>	 <b170af450807130654m2f800b10ybcba4b2c5c7cf329@mail.gmail.com>	 <487A1534.3000307@diamondcut.com.br> <b170af450807150017u248d4255i3800c10cb11df319@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-02.mandic.com.br ([200.225.81.133]:37526 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912AbYGOLNn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jul 2008 07:13:43 -0400
In-Reply-To: <b170af450807150017u248d4255i3800c10cb11df319@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-kernel@vger.kernel.org

Rafa=C5=82 Mi=C5=82ecki wrote:
> Renato S. Yamane wrote:
>> Rafa=C5=82 Mi=C5=82ecki wrote:
>>> I have Toshiba A100 with Phoenix BIOS. This means toshiba_acpi does=
n't
>>> work for me and I can change LCD brightness.
>>
>> Rafal, try use omnibook driver.
>>  Get it with subversion:
>>  $ svn co
>>  https://omnibook.svn.sourceforge.net/svnroot/omnibook/omnibook/trun=
k
>>
>>  Use "make install" and "make load".
>>
>>  After this, maybe is possible change brightness writing in
>>  /proc/omnibook/lcd (0 is minimun and 7 is max brightness)
>=20
> The newest version is packed for openSUSE fortunately. But it doesn't
> for my notebook

Try compile SVN version as commented in my last e-mail

> dmesg is:
> omnibook: Driver version 2.20070211-trunk.
> omnibook: Unknown model.

Try force recognize with ectype parameter.
#modprobe omnibook ectype=3Dx

Where "x" is a number between 1 and 15.

Load with ectype=3D1, test, unload, try load again with ectype=3D2, tes=
t,
unload...

Best regards,
Renato
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
