From: Gandalf Kristensen <gandkri@yahoo.no>
Subject: Re: Buggy BIOS on the HP tx2500-series
Date: Wed, 8 Oct 2008 22:09:53 +0200 (CEST)
Message-ID: <823417.81753.qm@web23003.mail.ird.yahoo.com>
References: <20081008192641.GA1932@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web23003.mail.ird.yahoo.com ([217.146.189.28]:34756 "HELO
	web23003.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752146AbYJHUJz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 16:09:55 -0400
In-Reply-To: <20081008192641.GA1932@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org


--- Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> A patch went into the kernel earlier this year to
> ignore critical trip=20
> points that were below 0. Does that not deal with
> the issue?
>=20
> --=20
> Matthew Garrett | mjg59@srcf.ucam.org
>=20

Ah. One kernel-compile and test-run later, yeah,
you're right. So it does.
Sorry for asking for help with a problem already dealt
with.
Thanks for looking in to this problem though.


--Gandalf A. Kristensen


      _________________________________________________________
Alt i ett. F=E5 Yahoo! Mail med adressekartotek, kalender og
notisblokk. http://no.mail.yahoo.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
