From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M3N and sleep states
Date: Tue, 30 Dec 2003 20:07:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FF1CD0D.6030602@pca.it>
References: <3FED7289.1070201@pca.it> <20031227215137.GA28438@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031227215137.GA28438-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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

on 12/27/03 22:51, Karol Kozimor wrote:
|>- - S1
<cut>
| [the following is for ASUS L3800C]
| Same here for USB (actually, unloading {usb-,}uhci suffices, 2.6 doesn't
| hang though). ALSA doesn't seem to care in my case.
| About the shutdown: it is likely that a PWRF event is issued after resume
| like in my case, kill acpid prior to suspending and see if it makes any
| difference (I reported the PWRF problem here a while ago, but have
| received no feedback so far).
sometimes I'm a bit stupid... You're right, there's a PWRF event once
you resume from S1 and this is the cause for the entering in 'INIT 0'.
Stopping 'acpid' or renaming the action associated to the PWRF event all
goes well: I got a complete S1 and a complete resume. There're 2 new
problems, now: after resuming from S1, the fan turns on loudly and I
can't reboot (but the 'shutdown -h now' works).

About the PWRF event, I sent this mail to the 'acpid' author: it seems
that any button you press to resume from S1 (so even not the
power-button), the 'acpid' generates a PWRF event. This should be avoid,
I mean, it seems that this happens only in S1 state and not in S3.

About the ALSA problem, maybe the *real* problem is related to the fact
that I've an 'osl-0892/semaphore' error in my 'dmesg' and at boot when
trying to load ALSA drivers (but they work without any problems): IIRC
this is a known problem on ASUS Centrino laptops (I'm sure at least on
ASUS M3N) and AFAIK there's no solution ATM.

|>- - S4
<cut>
| Kill X and unload AGP or use Nigel's patches from swsusp.sf.net.
I answered in the Pavel's mail about AGP/DRM modules. Question: the
Nigel's patches let you leave the AGP modules on?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/8c0MVAp7Xm10JmkRAo2+AJ4wCjY6ywGHpldiGlJdh1Pwvrp+KgCfQsYK
LyUlxjrdDn5rcngRBdh0rOQ=
=Spls
-----END PGP SIGNATURE-----




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
