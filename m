From: "Breathnach, Proinnsias  (Dublin)" <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>
Subject: ACPI _and_ APM ??
Date: 28 Feb 2003 14:26:52 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046442411.20792.183.camel@DUBIW89675.ie.ml.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Just curious if this should / shouldn't work ...

I've a Sony Vaio FX401 - AMD 800 512MB laptop, which works great with
almost any given version of the ACPI patches... unfortunately with the
way I've got the machine configured and the amount of RAM it's faster to
shutdown -h and reboot than to use SWSUSP (sorry Pavel !)

I have noticed that the APM suspend-to-ram works nicely (well apart from
the VTs blanking, but that's the FB code ..) and even returns cleanly
... and I was wondering if there's any real reason one couldn't use both
ACPI for config etc and APM for sleeping ?

Or am I losing the plot altogether ?

P




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
