From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: PBLK length again
Date: Fri, 25 Jun 2004 13:51:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40DC11A8.8060705@pca.it>
References: <BAY16-F112kKIBXEHt30004aded@hotmail.com>	 <20040620154726.GT20511@parcelfarce.linux.theplanet.co.uk>	 <1087770015.23371.27.camel@djinn>  <40D73F9E.4030805@pca.it> <1087850404.2501.43.camel@camel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1087850404.2501.43.camel-O4LVqDAXoJg@public.gmane.org>
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

on 06/21/04 22:40, Herman Sheremetyev wrote:

> From the research I've done I am fairly certain that 7 is not a legal
> value but Asus insists on breaking the spec by sticking 5's and 7's in
> PBLK length even though they mean 6, and Windows doesn't seem to mind.
> There should be a way for Linux to deal with this too I think.
I agree. And it seems that after having informed ASUS of this problem,
they don't care about it  :-(

>> ASAP I'll try your patch, just to confirm that it works on different
>> machines.
> Cool, I run a "Linux on the M6N" forum so you can post your results
> there as it probably doesn't need to be on this list:
>
> http://mrhammy2.ath.cx:81/forum/viewtopic.php?t=85
I know your site: it's there that I found that the ASUS M6N has an
S3_bios. Anyway, I'm posting here the results:
=====
luca-HSB4nKSusd8@public.gmane.org:~$ cat /proc/acpi/processor/CPU1/*
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      yes
limit interface:         yes
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
active state:            C2
default state:           C1
bus master activity:     00000000
states:
  C1:          promotion[C2] demotion[--] latency[000] usage[00088150]
 *C2:          promotion[--] demotion[C1] latency[099] usage[00399406]
  C3:          <not supported>
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%
luca-HSB4nKSusd8@public.gmane.org:~$
=====

> What this patch does is really no different from using a custom DSDT,
> in the end you're still overriding the value the BIOS provides with
> one that make sense to the OSPM system.  I'm definitely no expert on
> this stuff but I would think a kernel based solution (granted it
> should be nicer than my initial patch) is better than a DSDT based
> one.  Having either a compile-time or boot-time option to accept other
> values or maybe override the PBLK length would probably benefit a lot
> of people with broken BIOS's.
I agree, I prefer to not have a custom DSDT, but it's now always
possible  :-(

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFA3BGoVAp7Xm10JmkRAh0WAJ91cJ/hIGiFJnNOpzuRk1gjjAH39gCfRyiS
mEIR/2T80FKJsvHVPx2yLFs=
=Bfr7
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
