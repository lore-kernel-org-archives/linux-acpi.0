From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M3N and sleep states
Date: Mon, 05 Jan 2004 19:38:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FF9AF08.9010608@pca.it>
References: <3FED7289.1070201@pca.it> <20031227215137.GA28438@hell.org.pl> <3FF1CD0D.6030602@pca.it> <20040105181922.GK11597@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040105181922.GK11597-xsfywfwIY+M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: thockin-xsfywfwIY+M@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 01/05/04 19:19, Tim Hockin wrote:
| I don't know any of the backstory on these - what's up?  Anything I
need to
| look at?
sorry Tim, my mystake: here the complete thread
http://sourceforge.net/mailarchive/forum.php?thread_id=3676335&forum_id=6102
(I can't find my starting post, it seems SourceForge.net archive isn't
complete or I've no other reasons. Anyway, the 'incriminated' messages
are there)

| I *promise* you there is no PWRF event that acpid generates.  All
acpid does
| is relay the stuff your kernel sends.  And the kernel mostly relays BIOS
| stuff.
|
| acpid does not create anything on it's own.
Another mystake of mine, after my post I forgot to send you the reponse
from Karol Kozimor, who better explained my problem. Here his words:

on 12/30/03 21:56, Karol Kozimor wrote:
| It's got nothing to do with acpid, it's just a userspace daemon, anyway.
| The real problem is either somewhere in BIOS (and no, it's not in the AML
| either) or in the ACPI code. For the record, I get the PWRF also after S3.
|
| And no, I'm not pressing the power button to resume.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/+a8HVAp7Xm10JmkRAnAVAJ9lL9fGyZTCDuCweg+oPaaR9lt5ngCffQn8
QrAthBcIRDMC0MBjMMfXGw0=
=XLrx
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
