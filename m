From: "Adrian Yee" <adrian-OU8u6/KFdmW45Ov3ckaPZVaTQe2KTcn/@public.gmane.org>
Subject: Re: S3 suspend/resume driver questions
Date: Mon, 19 Apr 2004 19:29:04 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <GMail.1082428144.185967099.64745017839@brewt.org>
References: <32839.66.245.64.93.1082425332.squirrel@webmail.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <32839.66.245.64.93.1082425332.squirrel-2RFepEojUI2yzif+TlFmFpQCsf4PZ8us@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Ilya,

> Your patch worked beautifully on my Fujitsu E7010 laptop.  Prior to the
> patch, the system would lock up hard if I tried to load snd_intel8x0 after
> waking up from S3.  If I didn't not unload the sound modules before going
> to sleep, the system would not wake up at all (lock up would happen on
> resume).  In any case, the sound "just works" (tm) now.

Nice to know.  From what I've seen, it looks like Fujitsu is pretty good wi=
th keeping things consistent between their different lines of notebooks.  T=
hey usually reuse components (the prism2 wifi card in your notebook is prob=
ably the same card as the one that's in my notebook [which is also used in =
the P2xxx series too]).  I'm guessing this patch I've modified would work o=
n your notebook too (read the header of the patch):

http://devrandom.com/fujitsu/fujitsu_acpi-2.6.patch

It adds LCD brightness, volume and pointer status functionality and the abi=
lity to change them too.  Let me know if it works for you.

Adrian


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
