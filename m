From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: Success with kernel-swsusp and Nvidia-closed-source
Date: Mon, 8 Nov 2004 16:47:05 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0411081640410.4713@frog.athome>
References: <Pine.LNX.4.60.0411031215260.1187@frog.athome>
 <Pine.LNX.4.60.0411041729180.4727@frog.athome> <200411041812.54813.christian.hesse@linuxob.de>
 <200411072052.53065.mail@earthworm.de>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411072052.53065.mail-8oMOrB1mGocUSW6y5lq3GQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christian Hesse <mail-8oMOrB1mGocUSW6y5lq3GQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Christian,
On Sun, 7 Nov 2004, Christian Hesse wrote:
>>> Let us know if this gets you any further. When I find time, I will give
>>> swsusp 2.1 another try myself!
>>
>> I disabled AGP in my kernel config, recompiled the module and added the
>> line mentioned above in my xorg.conf - nothing changed. Screen is still
>> black after resume. But I can confirm that I can log in via network and
>> killall -9 X.
>
> Tried with nvidias new driver 1.0-6629 today. I managed to make it work once,
> but I couldn't reproduce it... :(
I am verry impressed. I had a try myself today and did not succeed. Then I 
took a look at the driver (6629 -> nv.c) and discovered, that they removed 
all ACPI support, which was in 6111. So your once success with 6629 is a 
little miracle. But maybe ACPI is not allways needed :-))))
So, from time to time, I have the trouble, that my keyboard is not 
behaving well after suspend (which comes from X). When I login over the 
network, and issue a
  chvt 6
  chvt 7
sequence, all will be back to normal. I start now including a change to 
vt-6 before suspending into my script. I will report back, if this is a 
better solution.
So for the record: working for me: 2.6.9-vanilla+nv-6111+haggis
                                    2.6.8-vanilla+nv-6111+haggis
                                    2.6.9+sw2.1.1+nv-6111+haggis

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFBj5T+9bBoTzOf1pMRAinaAKDk2Oi3ZpjR3Gw3saqgpR9nncyU3wCfXpZQ
gGblWm6+Um3MX66fuTdjP84=
=/onx
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
