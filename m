From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: asus_acpi, support F2JE model
Date: Wed, 11 Apr 2007 15:46:18 +0200
Message-ID: <461CE6AA.6050806@gmail.com>
References: <22473653910004885@karneval.cz> <200704111505.03625.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752702AbXDKNsI@vger.kernel.org>
In-Reply-To: <200704111505.03625.corentincj@iksaif.net>
Sender: linux-kernel-owner@vger.kernel.org
To: corentincj@iksaif.net
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, sziwan@users.sourceforge.net, acpi4asus-user@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Corentin CHARY napsal(a):
> Le Wednesday 11 April 2007 11:33:48 Jiri Slaby, vous avez =C3=A9crit =
:
>> asus_acpi, support F2JE model
> Just use the new asus-laptop driver =3D)
> (see acpi4asus-0.40)

code seems good, but this is not so good:
#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,20)
#warning "This module does not support 2.6.20 yet, wait for a new relea=
se =3D)"
#endif

When do you plan to support latest kernels and merge it to mainline?

thanks,
--=20
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
