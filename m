From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: Error calling BSTS
Date: Sat, 2 Dec 2006 08:27:56 +0100
Message-ID: <200612020827.56692.corentincj@iksaif.net>
References: <4570BECB.5050502@seclark.us>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:387 "EHLO iksaif.net")
	by vger.kernel.org with ESMTP id S936495AbWLBH17 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Dec 2006 02:27:59 -0500
In-Reply-To: <4570BECB.5050502@seclark.us>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen.Clark@seclark.us, linux-acpi@vger.kernel.org

Le samedi 2 d=E9cembre 2006 00:46, Stephen Clark a =E9crit=A0:
> Asus Laptop ACPI Extras version 0.30
>   Error calling BSTS
>   unsupported model Z96F, trying default values
>   send /proc/acpi/dsdt to the developers

Please send /proc/acpi/dsdt, not dmidecode output :)
cat /proc/acpi/dsdt > /tmp/dsdt=20

--=20
CHARY 'Iksaif' Corentin
http://xf.iksaif.net
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
