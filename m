From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 15:44:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FBE24DC.8020203@pca.it>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org> <20031121111323.GB18223@luna.mooo.com> <3FBE0E02.3080203@pca.it> <20031121135321.GF5917@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031121135321.GF5917-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
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

Hello Micha,

on 11/21/03 14:53, Micha Feigin wrote:
| If you are using acpi look into acpid to be able to act upon acpi
| events.
| I this case, with acpid not running do (assuming you do have acpi
| support, otherwise you won't see this file)
| cat /proc/acpi/event
| and pull out your power cord and then reinsert it. If you are getting
| ACAD or BAT or somesuch thing messages then everything is ok (I don't
| know how to do this with apm) and you can use acpid to run the
| laptopmode script whenever your power is connected/disconnected.
yes, I can, I mean, I had already checked for this event (AC-adapter)
and it works :-) BTW, for those who don't know, I'm using an ASUS M3N
(Centrino) with the latest BIOS available (0205A released 20031117).
I've just a little problem and I'm going to inform this list ASAP (I
need some tests before).

| Will look into it.
Thank you very much!

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/viTaVAp7Xm10JmkRAuHGAJ910nA2C57ZEyGlZ2ymRZQpTBwFjQCfXlIy
xCTsJEBr1k1Pqb+LvwC11rw=
=+fWR
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
