From: katabami <katabami@lavabit.com>
Subject: Re: [PATCH] ACPI thermal: _TMP and _CRT/_HOT/_PSV/_ACx dependency
 fix
Date: Wed, 28 Nov 2012 13:25:34 +0900 (JST)
Message-ID: <20121128.132534.1145529873803098747.katabami@lavabit.com>
References: <1353981690.2157.5.camel@rzhang1-mobl4>
	<13424597.Clh1ApcFoE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from karen.lavabit.com ([72.249.41.33]:35028 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937Ab2K1Glk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Nov 2012 01:41:40 -0500
In-Reply-To: <13424597.Clh1ApcFoE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com, mjg@redhat.com

On Tue, 27 Nov 2012 20:55:22 +0100, "Rafael J. Wysocki" wrote:
> I'm going to apply it, but with a few cleanups.  The result is append=
ed, please

I patched it against linux-3.4.9 on HP compaq 6715s, and it works. Dzi=EA=
kuj=EA, (Thank you), Rafael.

On Tue, 27 Nov 2012 20:55:22 +0100, "Rafael J. Wysocki" wrote:
> On Tuesday, November 27, 2012 10:01:30 AM Zhang Rui wrote:
>> From 391908867c2a500a9068aa9f2a8e74663fff75ac Mon Sep 17 00:00:00 20=
01
>> From: Zhang Rui <rui.zhang@intel.com>
>> Date: Fri, 23 Nov 2012 09:25:10 +0800
>> Subject: [PATCH] ACPI thermal: _TMP and _CRT/_HOT/_PSV/_ACx dependen=
cy fix
>>=20
>> On some platforms, _TMP and _CRT/_HOT/_PSV/_ACx have dependency.
>> And there is no way for OS to detect this dependency.
>>=20
>> commit 9bcb8118965ab4631a65ee0726e6518f75cda6c5 shows us a problem
>> that _TMP must be evaluate after _CRT/_HOT/_PSV/_ACx, or esle
>> firmware will shutdown the system.
>>=20
>> But the machins in https://bugzilla.kernel.org/show_bug.cgi?id=3D432=
84
>> shows us that _PSV would return valid value only if _TMP has been
>> evaluated once.
>>=20
>> With this patch, all of the control methods will be evaluated once,
>> in the order of  _CRT/_HOT/_PSV/_CRT, _TMP, before they are actually=
 used.
>=20
> I'm going to apply it, but with a few cleanups.  The result is append=
ed, please
> double check if it is still correct.
>=20
> Thanks,
> Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
