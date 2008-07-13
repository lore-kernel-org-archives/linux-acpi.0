From: "Renato S. Yamane" <yamane@diamondcut.com.br>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Sun, 13 Jul 2008 11:46:12 -0300
Message-ID: <487A1534.3000307@diamondcut.com.br>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com> <b170af450807130654m2f800b10ybcba4b2c5c7cf329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-01.mandic.com.br ([200.225.81.132]:60401 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbYGMOq2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Jul 2008 10:46:28 -0400
In-Reply-To: <b170af450807130654m2f800b10ybcba4b2c5c7cf329@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-kernel@vger.kernel.org

Rafa=C5=82 Mi=C5=82ecki wrote:
> 2008/6/17, Greg KH <greg@kroah.com>:
>> Are there any known drivers for Toshiba hardware that you need for L=
inux
>>  that we should be contacting them about?
>> <http://linux.toshiba-dme.co.jp/linux/eng/develop.htm>
>=20
> I have Toshiba A100 with Phoenix BIOS. This means toshiba_acpi doesn'=
t
> work for me and I can change LCD brightness.
>=20
> On page http://www.buzzard.me.uk/toshiba/docs.html there is also link
> to pdf with registers info:
> http://www.buzzard.me.uk/toshiba/downloads/hci.pdf
>=20
> However I am not programmer and I have no idea if this is some
> interesging info for developrs.

Rafal, try use omnibook driver.
Get it with subversion:
$ svn co
https://omnibook.svn.sourceforge.net/svnroot/omnibook/omnibook/trunk

Use "make install" and "make load".

After this, maybe is possible change brightness writing in
/proc/omnibook/lcd (0 is minimun and 7 is max brightness)

Best regards,
Renato S. Yamane
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
