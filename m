From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 21 Nov 2003 14:07:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FBE0E02.3080203@pca.it>
References: <C386328088ED7F4E9F81AFBABDDF60DA03386202@wdmyexch02.my.asia.wdc.com> <20031121101232.GL32464@poupinou.org> <20031121111323.GB18223@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031121111323.GB18223-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
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

on 11/21/03 12:13, Micha Feigin wrote:
| like said here, laptopmode is what you want since it holds back dirty
| buffer flushes which is what you are experiencing. It will fire up the
| disk on reads though. I attached a script that you can use to enter
| laptopmode (was actually distributed with laptopmode as far as I could
| tell when googling for the original patch). I call it in responce to
| ac events from acpid to get it running when the power is disconnected.
| Will have to make sure that you get those event though since I had to
| twik my dsdt for that.
thx for the script, I was searching for but I couldn't find :-(
On the other hand, what do I search for in my DSDT? I mean, in which way
can I know if the 'laptop_mode' is supported on my DSDT?

| I could try making such a patch for ext3 if you want.
Yes, please :-)

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/vg4AVAp7Xm10JmkRAmsWAJ928z25MNHuka49V08QWHa0NryAxACdFX8I
iEg+mpKXPRz2VGqOOmu8y3g=
=liFy
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
