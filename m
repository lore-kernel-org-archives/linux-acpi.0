From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Unable to turn fan on - Asus M3N - 2.6.0-test9bk4
Date: Thu, 13 Nov 2003 18:36:11 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FB3C10B.7070507@pca.it>
References: <20031101193817.GA19198@austinchronicle.com> <20031102174730.GB2819@krikkit> <3FA561F7.5030706@pca.it> <20031104173216.GH26114@austinchronicle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031104173216.GH26114-lfYnT2qr6k+7/ODoCphcOEEOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Lindsey,

sorry for the late answer, but I was a bit busy and it seems I've some
problem sending mails to ACPI-devel mailing-list.

on 11/04/03 18:32, Lindsey Simon wrote:
| My FN00/state's change from on to off as well, but the fan doesn't
actually
| turn on when the state says it's on.
|
| Do you insmod the fan module or not? I do, but maybe I shouldn't?
|
| Which of the ACPI modules do you turn on and which do you not?
Here my /etc/modules:
=====
<cut>
# ACPI
ac
battery
button
fan
processor
thermal
# acpiphp
asus_acpi
<cut>
=====

As you could see, I all the ACPI modules inserted, except the 'ACPI
Hotplug' one.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/s8EKVAp7Xm10JmkRArcEAJ48hQkvANgkqYFOKL4rJireMP3h1ACeI1Qn
z/BnP4gC5JtAQCKSdQX8fZE=
=98+2
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
