From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Resume from suspend-to-ram (radeon)
Date: Wed, 31 Mar 2004 14:44:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <406ABD4A.10408@pca.it>
References: <c15rn0$5bu$2@sea.gmane.org>	<1077519609.12675.63.camel@dhcppc4> <20040223074227.80AE57831D@mail.lmc.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040223074227.80AE57831D-Yo/1PYb2HdawRS80dfYGFoIJIQD0bWaD@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 02/23/04 08:42, Giridhar Pemmasani wrote:
> New radeonfb suspend/resume code turns the LCD on but the system hangs
> during fb resume. With the changes I made, the LCD turns on but the
> screen remains blank. X with int10 POST restores the screen properly.
I haven't tried S3/S4 yet, but I suppose the problem will be similar on my ATI
Radeon 9600 M10 NP laptop. Simple question: in which way X restores the screen?
I mean, I've seen other posts on other mailing-lists about POST command which
can be restore LCD after resume, but I don't know how I can do it.. Could
explain me or provide some docs?

Another simple question: is there a documentation about 'radeonfb'? If I compile
it in the kernel, I've no problem, but as modules I get this error:
	radeonfb: Unknown symbol fb_find_mode

> It turns out that I don't have to remove radeon (drm module),
> intel_agp and agpgart modules before suspend (and insert during
> resume). The only subsystems that cause problems are ALSA and USB;
> once these modules are removed, everything works fine. Apparently OSS
> sound module i810_audio (for 82801DB audio controller)
> suspends/resumes properly so now I am using it instead of ALSA.
One possible solution for 'intel8x0' suspend/resume problem is here
   http://sourceforge.net/mailarchive/forum.php?thread_id=4107033&forum_id=1752

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAar1KVAp7Xm10JmkRAuROAJ4mwFi3ZPEAbR52IjVdvjWBdfp1ogCfcNXG
1HPpWGxh0ElrX7CSxRE7LQ0=
=mFJl
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
