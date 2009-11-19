From: Frank Richards <frank@richards.homelinux.com>
Subject: [Fwd: Re: [Question #90813]: last 2 kernels fail on Asus M2N68-VM]
Date: Thu, 19 Nov 2009 21:06:45 +1100
Message-ID: <4B0518B5.4080607@richards.homelinux.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050204030907040003060200"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nschwqsrv02p.mx.bigpond.com ([61.9.189.234]:36537 "EHLO
	nschwqsrv02p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751314AbZKSKvt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Nov 2009 05:51:49 -0500
Received: from nschwotgx01p.mx.bigpond.com ([121.223.131.25])
          by nschwmtas06p.mx.bigpond.com with ESMTP
          id <20091119100642.KNVY22839.nschwmtas06p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>
          for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2009 10:06:42 +0000
Received: from [192.168.1.92] (really [121.223.131.25])
          by nschwotgx01p.mx.bigpond.com with ESMTP
          id <20091119100640.PUUL1743.nschwotgx01p.mx.bigpond.com@[192.168.1.92]>
          for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2009 10:06:40 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050204030907040003060200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

C.F.Y.I.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAksFGLUACgkQNi6/b/kMM2yArgCZAQ+n4RSWqZvn+cE09GvWX7gJ
DBEAnRxP42WltTSn/1rAnPApmSGQ7bZu
=lnah
-----END PGP SIGNATURE-----


--------------050204030907040003060200
Content-Type: message/rfc822;
 name="Re: [Question #90813]: last 2 kernels fail on Asus M2N68-VM.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Re: [Question #90813]: last 2 kernels fail on Asus M2N68-VM.";
 filename*1="eml"

Return-Path: <bounces@canonical.com>
X-Original-To: frank@richards.homelinux.com
Delivered-To: frank@richards.homelinux.com
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by richards.localdomain (Postfix) with ESMTP id 2CD7B1BD63
	for <frank@richards.homelinux.com>; Thu, 19 Nov 2009 21:00:44 +1100 (EST)
Received: from loganberry.canonical.com ([91.189.90.37])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1NB3oe-0006hG-1J
	for <frank@richards.homelinux.com>; Thu, 19 Nov 2009 10:00:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 772742E80D5
	for <frank@richards.homelinux.com>; Thu, 19 Nov 2009 10:00:35 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Launchpad-Question: distribution=ubuntu; sourcepackage=None; status=Open;
	assignee=None; priority=Normal; language=en
X-Launchpad-Message-Rationale: Subscriber
Reply-To: question90813@answers.launchpad.net
References: <20091119093308.30440.6278.lpquestions@wampee.canonical.com>
To: frank@richards.homelinux.com
From: friendlyfrank <question90813@answers.launchpad.net>
Subject: Re: [Question #90813]: last 2 kernels fail on Asus M2N68-VM
Message-Id: <20091119100035.21619.38816.launchpad@loganberry.canonical.com>
Date: Thu, 19 Nov 2009 10:00:35 -0000
Sender: bounces@canonical.com
Errors-To: bounces@canonical.com
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="None";
	Instance="initZopeless config overlay"
X-Launchpad-Hash: 62270bfafc5a8ba2da4a5bd7fc679489f51a979b

Your question #90813 on Ubuntu changed:
https://answers.launchpad.net/ubuntu/+question/90813

    Status: Needs information =3D> Open

You gave more information on the question:
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Colin King wrote:
> Your question #90813 on Ubuntu changed:
> https://answers.launchpad.net/ubuntu/+question/90813
>
>     Status: Open =3D> Needs information
>
> Colin King requested for more information:
> The error message is because your BIOS does not have a correctly
> configured ACPI _PSS (Performance Supported States) object. Section
> 8.4.4.2 of the ACPI specification states that this is an optional ACPI
> object that indicates to operating system the number of supported
> processor performance states that the system can support.
>
> The _PSS object is essentially a list of information about available
> performance states including internal CPU core frequency, typical power
> dissipation and the control register values needed to transition between
> performance states.
>
> It's worth contacting the BIOS provider and/or ASUS and reporting this
> as a BIOS issue. Also it's worth contacting the Linux ACPI maintainers
> (linux-acpi@vger.kernel.org).
>
> Is this problem causing your kernel not to start?
>
No
 it looks like the nvidea driver problem and the terminal screen
flashes ntp and unable to log on

which logs would be the most helpfull?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAksFFxYACgkQNi6/b/kMM2wT8gCfcGa1lI9LW7Nm2X6GE3BAaTpt
/8YAnRNIWj/8cmFgR1oElp5wbJJI4j8Y
=3Dlwv0
-----END PGP SIGNATURE-----

-- =

You received this question notification because you are a direct
subscriber of the question.

--------------050204030907040003060200--
