From: Martin Emrich <martin-Lib3zZxmLlyPMHZYdLIcP2D2FQJk+8+b@public.gmane.org>
Subject: S3 hangs Sony Notebook
Date: Tue, 11 Nov 2003 22:07:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068584857.1419.11.camel@garrett.darkzone>
Reply-To: emme-K4UpdBpcDjFP6xvG9yNuTA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I'm experimenting with Kernel 2.6.0-test9 + acpi-20031002-2.6.0-test9
patch on my Sony Vaio PCG-F403 (P3-450, i440BX, PhoenixBIOS, both APM
and ACPI capable). But I have several problems:

- I have to use "acpi=force" because otherwise it says my BIOS is too
old. (Actually, I have the newest BIOS from Sony (dated 2000...*hmm*)

- reading Battery status works, but it always says "... battery will
never fully charge", although it charges up to 100%

- When entering S3 state, some lines appear (something about hda, it is
gone too fast to read), then the screen blanks and the power LED blinks
red slowly, just like with Suspend-To-RAM in APM mode (which works fine
btw.). But then I can't turn it on again, neither can I turn it off. I
have to unplug the PSU and remove the battery to turn it off completely.
(IIRC somebody posted the same problem with a Dell notebook some time
ago).

- Since I'm running ACPI, my system clock does weird things (going
forward/backward some hours or days - ntpdate is my friend ;-)

Most important for me is to get S3 working. Is there any chance?
Furthermore, what is the best way to test if the different cpu
throttling settings have any effect at all?

Thanks

Martin Emrich



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
