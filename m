From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Subject: Re: VGA patch by Bruno Ducrot -- no success yet
Date: Fri, 13 Feb 2004 00:04:52 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3r7wzx5kb.fsf@reason.gnu-hamburg>
References: <m3u11wnflb.fsf@reason.gnu-hamburg>
	<20040212223706.GA13262@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040212223706.GA13262-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> (Bruno Ducrot's message
 of "Thu, 12 Feb 2004 23:37:06 +0100")
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=

 || On Thu, 12 Feb 2004 23:37:06 +0100
 || Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote: 

 >> cat ./LCDD/brightness
 >> <not supported>

 bd> For an LCD device, that not very fun unfortunately :(

I'm not sure how these relate to each other, but we're talking ASUS
M2N here, which uses the acpi4asus code, in which

 /proc/acpi/asus/
 |-- brn
 |-- disp
 |-- info
 |-- lcd
 `-- mled

exist. And therefore

 /proc/acpi/asus/brn

normally regulates background display brightness for the LCD, while
lcd toggles the backlight on/off. Unfortunately both have no effect on
the dead screen after S3.

Don't know whether/how this interacts with your code.


 >> cat ./ROM
 >> <TODO>

 bd> Well, that need to be done as said, even though in fact that is
 bd> really uncommon though.

I know -- just wanted to give you the complete picture. .)


 >> Feb 12 21:54:30 myhost kernel: Uninitialised timer!
 >> Feb 12 21:54:30 myhost kernel: This is just a warning.  Your computer is OK
 >> Feb 12 21:54:30 myhost kernel: function=0x00000000, data=0x0
 >> Feb 12 21:54:30 myhost kernel: Call Trace:
 >> Feb 12 21:54:30 myhost kernel:  [check_timer_failed+99/101] check_timer_failed+0x63/0x65
 >> Feb 12 21:54:30 myhost kernel:  [del_timer+26/135] del_timer+0x1a/0x87
 >> Feb 12 21:54:30 myhost kernel:  [_end+541737980/1069013880] ehci_stop+0x73/0xde [ehci_hcd]
 >> Feb 12 21:54:30 myhost kernel:  [preempt_schedule+42/67] preempt_schedule+0x2a/0x43

 bd> Is the system more stable without preempt, btw?

I'll try... although it shouldn't make a difference, or should it?


 >> Hope this helps with the debugging... :-)

 bd> Yes, at least for the latter oops, I will be gratefull if you
 bd> send me a brown bag...

There is always one of the little suckers that you didn't think of. .-)


 bd> --- video.c	2004/02/12 22:26:41	1.1
 bd> +++ video.c	2004/02/12 22:34:21
 bd> @@ -617,6 +617,9 @@
 bd>  	if (!dev || count + 1 > sizeof str)
 bd>  		return_VALUE(-EINVAL);
 
 bd> +	if (!dev->brightness)
 bd> +		return_VALUE(-ENODEV);
 bd> +
 bd>  	if (copy_from_user(str, buffer, count))
 bd>  		return_VALUE(-EFAULT);

Yeah, that should get rid of that one. 

But since it probably won't help bringing the display back to life I
won't recompile for that fix, I guess.


 >> P.S. Oh yeah, machine is ASUS M2N, Intel 855GM, more info:
 >> http://bugme.osdl.org/show_bug.cgi?id=1774#c3

 bd> Thanks for testing!

Thanks for tackling that issue!

When you have another version you think might help with the dead
screen issue or need more input, please let me know. I don't really
have a lot of time but compiling a kernel by the side is usually
possible. :)

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFALAaUbvivwoZXSsoRAtkfAJ4sugJhdV9IuVUE1eeQp2zmbwPpOgCfY8ik
FgtFDtel1x86HSkNCNgx0Aw=
=2Wa+
-----END PGP MESSAGE-----
--==-=-=--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
