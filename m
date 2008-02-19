From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: 2.6.25-rc2-mm1 (x64 thermal build failure)
Date: Tue, 19 Feb 2008 14:05:45 -0800
Message-ID: <47BB52B9.5020702@oracle.com>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org>	<20080216211603.bb4f3582.randy.dunlap@oracle.com>	<20080216214410.b9699910.akpm@linux-foundation.org>	<20080218111536.511c4fbc@crazy>	<20080218041340.f1e46ec9.akpm@linux-foundation.org>	<20080219165502.2c202759@crazy>	<20080219094147.b9e0e99b.randy.dunlap@oracle.com> <20080219230016.5b7ff43d@crazy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:61154 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbYBSWGr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Feb 2008 17:06:47 -0500
In-Reply-To: <20080219230016.5b7ff43d@crazy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org, michael@free-electrons.com

Thomas Petazzoni wrote:
> Le Tue, 19 Feb 2008 09:41:47 -0800,
> Randy Dunlap <randy.dunlap@oracle.com> a =E9crit :
>=20
>> Does this patch apply to -mm?  Seem like No.
>=20
> No, it was generated against 2.6.25-rc2.
>=20
>> After converting it from mime(?) to ASCII
>=20
> Probably due to my PGP-MIME signature. Will try to remember that
> I should disable it next time.
>=20
>> and fixing one #if (change "and" to "&&")
>=20
> Oops. Fixed on my side too.
>=20
>> & fixing patch rejects, it does build cleanly.
>=20
> The rejects are probably due to the patch being applied to -mm. It
> applies fine on -rc here.
>=20
> Any opinion about whether the patch is clean ? Worth it ?

It seems reasonable to me as long as the option depends on EMBEDDED,
as it does.

--=20
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
