From: "Yu, Ling L" <ling.l.yu@intel.com>
Subject: RE: DSDT database
Date: Sat, 9 Sep 2006 15:47:43 +0800
Message-ID: <D352FD896397D04482B87731BD4DBE7FD7C182@bjsmsx401>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26693 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751394AbWIIHtG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 9 Sep 2006 03:49:06 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Thomas W. Carley" <tcarley@embedded-zone.com>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

This bundle for the total 652 DSDT files is available here: http://acpi=
=2Esourceforge.net/dsdt/dsdtall.tar.gz=20

Thanks
- Ling

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org
>[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Thomas W. Carle=
y
>Sent: 2006=C4=EA9=D4=C28=C8=D5 11:38
>To: Yu, Ling L
>Cc: linux-acpi@vger.kernel.org; Len Brown
>Subject: Re: DSDT database
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Never mind bundling them for me, I hacked up a little script to get th=
em
>all.
>
>FYI, I used the following script to make a web page with links to all =
of
>the DSDT files.
>
>for ((i=3D0;i<=3D1000;i+=3D1));
>do
>	echo '<A href=3D"http://acpi.sourceforge.net/dsdt/dl.php?id=3D'$i'"> =
DSDT
>'$i'</A>' >> links.html;
>done
>
>The I loaded links.html into firefox and used the down them all
>extension to download all of the links. Some of them are not valid, an=
d
>result in files named "---custom.gz". Once these are erased I am left
>with 652 files.
>
>Yu, Ling L wrote:
>>>> I am looking into the level of SMBus support in ACPI implementatio=
ns.
>> I
>>>> see that the sourceforge project has 652 DSDT's in its database. I
>> would
>>>> like to run some automated scripts over these to get some statisti=
cs
>>>> about the level of SMBus support. However, downloading them one at=
 a
>>>> time will take forever. Is the DSDT database available in whole? C=
an
>>>> someone send me a link, or send the files directly?
>>> Maybe Yu Ling knows how to get "behind the mirrors" of the web serv=
er
>>> and can run something for you there?
>> Thomas,
>> Do you really need all DSDTs on sourceforge web?
>> If yes, I will try to export them and make a whole tarball, put
>> somewhere to let you download.
>>
>> Thanks
>> - Ling
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.4.3 (MingW32)
>Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
>iD8DBQFFAbhsM+ThSqsPpFsRAv8kAKDfqaXFcJY+jiCPD0LXwRl3eqVZ+gCgoBet
>dfEiIamd2Sp+fGZOLYyMCss=3D
>=3DQHcE
>-----END PGP SIGNATURE-----
>-
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" =
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
