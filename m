From: Jari Ruusu <jari.ruusu-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org>
Subject: Re: ACPI + loop(AES) + swsusp
Date: Mon, 05 Aug 2002 19:08:14 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D4EA2EE.C5252944@pp.inet.fi>
References: <Pine.LNX.4.44.0208050914050.15185-100000@xborg.ipp-hgw.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Robert Stark <rstark-viLzafFedAGELgA04lAiVw@public.gmane.org>
Cc: Linux Mailinglists <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-crypto-qDhp9YYfzQpg9hUCZPvPmw@public.gmane.org, swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Robert Stark wrote:
> I've patched kernel-2.4.18 with acpi-20020726-2.4.18.diff, patch-acpi-acpi20020726-swsusp11,
> and use Jari's loopaes. All partitions, also the root partition are encrypted symmetric.
> 
> I work on a Sony-PCG-FX501 and ACPI and loopaes do all the things they should do.
> Have tested swsusp on the same machine without loopaes( and standard loop device )
> successfully, but when i have an loop device losetuped and send an 'echo 4 > /proc/acpi/sleep'
> then swsusp says "Strange, loopX not stopped" and abort suspend. After this error all loop devices
> are under load and i must reboot the system.
> 
> Is there a way get this envoirement to work ?

Swsusp requires that loop thread puts itself to 'refrigerator' before
suspend can happen. Current version of loop-AES just does not do that and is
incompatible with swsusp.

And even if loop thread did the 'refrigerator' thing, it would be really bad
security wise because the encryption keys would be written to disk when
kernel RAM is saved to disk. Of course that is not a problem with
unencrypted loops.

Robert, can you send me URLs of the patches that you used? It may be
possible to add such code in '#ifdef CONFIG_SWSUSP / #endif' hunks, so that
it gets activated only if swsusp is enabled in kernel config. I can't
promise that it gets merged, but I will at least take a look at it.

Regards,
Jari Ruusu <jari.ruusu-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
