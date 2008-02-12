From: Jan-Simon =?utf-8?q?M=C3=B6ller?= <dl9pf@gmx.de>
Subject: Re: Fwd: FSC Esprimo Mobile V5505 - dmidecode
Date: Tue, 12 Feb 2008 11:57:33 +0100
Message-ID: <200802121157.33691.dl9pf@gmx.de>
References: <200710122357.46851.dl9pf@gmx.de> <200710131013.55290.dl9pf@gmx.de> <200801182329.49567.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760776AbYBLK5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Feb 2008 05:57:41 -0500
In-Reply-To: <200801182329.49567.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Sorry for the late reply !

Am Samstag 19 Januar 2008 05:29:49 schrieb Len Brown:
> On Saturday 13 October 2007 04:13, Jan-Simon M=C3=B6ller wrote:
> > System Information
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: ESPRIMO Mobile V5505
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: 20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKU Number: Not Specified
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Family: Not Specified
> >
> > Handle 0x0002, DMI type 2, 8 bytes
> > Base Board Information
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: ESPRIMO Mobile V5505
>
> Jan-Simon,
> Thanks for the dmidecode output.
>
> Did the console dmesg ask you to send it because
> of OSI(Linux)?
>
> Do you notice any functional difference when booting with
>
> "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
> vs.
> "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
>
> Also, please send me the output from acpidump.
Didn't notice any difference.
acpidump here:

http://bugzilla.kernel.org/show_bug.cgi?id=3D9939

> thanks,
> -Len
>

Thanks!
Jan-Simon
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
