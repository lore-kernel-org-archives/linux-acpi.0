From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M3N and sleep states
Date: Thu, 01 Jan 2004 00:18:36 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FF3594C.8030104@pca.it>
References: <3FED7289.1070201@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FED7289.1070201-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 12/27/03 12:52, Luca Capello wrote:
| - S3
| without USB and ALSA, the fan turns on suddendly after the 'echo 3 >
| /proc/acpi/sleep', as when my OS hangs for other reasons. IMHO this is a
| problem with the BIOS (and the DSDT), as once I shut down the PC
| pressing 5sec the power-button, I need to press 2 times the power-button
| to reach again a boot (the first time I press the power-button, the
| laptop powers on and suddenly powers off).
I should say that this is not exactly: I made some other tests and
actually resuming from S3 is ok in 90% but the screen remains blank.
Sometimes the fan turns on and I can't shutdown (but this happens when
the temperature is too high). The other times, I can launch any
commands: I see the HD light blinking and I heard the HD working. More,
'shutdown -h now' works and I get a clean shutdown (but 'reboot' doesn't
work.

Here the complete situation: I can get S3 and a complete clear resume
even with the ALSA modules on and AGP. I tried it once I was logged in X
via GDM and it worked :-) This didn't with the USB modules on (as it was
supposed to be).

Another striking thing is that while normally the screen remains blank
during shutdown, if I enter in S3 from an X terminal and then I start
the shutdown (always without seeing my typing), then I can see the first
console (tty1) appearing and showing some messaged about the shutdown
process (just the "Shutdown called from..." and "acpid_power_off_called"
or something similar). This doesn't happen if I try from tty2, I mean, I
can't see tty1 in any other ways.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/81lJVAp7Xm10JmkRAgDNAJ9Om3RmoAbTv11Bw68v3ImhEUyaegCggyi5
IiADUOXuEXYKUKnfq1NAy1k=
=k5+z
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
