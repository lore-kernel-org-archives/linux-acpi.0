From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: Error calling BSTS
Date: Mon, 4 Dec 2006 18:56:48 +0100
Message-ID: <200612041856.48871.corentincj@iksaif.net>
References: <4570BECB.5050502@seclark.us> <200612020827.56692.corentincj@iksaif.net> <4571925C.3090204@seclark.us>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:55911 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935968AbWLDR45 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2006 12:56:57 -0500
In-Reply-To: <4571925C.3090204@seclark.us>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen.Clark@seclark.us
Cc: linux-acpi@vger.kernel.org

Le samedi 2 d=E9cembre 2006 15:49, Stephen Clark a =E9crit=A0:
> Corentin CHARY wrote:
> >Le samedi 2 d=E9cembre 2006 00:46, Stephen Clark a =E9crit :
> >>Asus Laptop ACPI Extras version 0.30
> >>  Error calling BSTS
> >>  unsupported model Z96F, trying default values
> >>  send /proc/acpi/dsdt to the developers
> >
> >Please send /proc/acpi/dsdt, not dmidecode output :)
> >cat /proc/acpi/dsdt > /tmp/dsdt
>
> Ok here it is as a DSDT binary blob.
>
> Thanks,
> Steve
Can you try the current cvs version of asus_acpi ?
http://acpi4asus.sourceforge.net/

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
