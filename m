From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: [patch 1/7] asus-laptop: add base driver
Date: Mon, 29 Jan 2007 10:09:38 +0100
Message-ID: <200701291009.39073.corentincj@iksaif.net>
References: <3D8E84095C6A524A985B787423094E40A75B26@mssmsx411>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:40789 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933284AbXA2JJv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jan 2007 04:09:51 -0500
In-Reply-To: <3D8E84095C6A524A985B787423094E40A75B26@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Suietov, Fiodor F" <fiodor.f.suietov@intel.com>
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Thanks, I didn't know this function =3D).
But maybe we should first merge this series, and then I will make a pat=
ch to=20
remove read_acpi_int().

Le vendredi 26 janvier 2007 19:48, Suietov, Fiodor F a =E9crit=A0:
> Please use acpi_evaluate_integer() instead of read_acpi_int().
>
> Thanks,
>  Fiodor
>
--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
