From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: patched sms-cm acpi/ec.c to 2.6.11.5
Date: Mon, 21 Mar 2005 23:03:41 +0000
Message-ID: <423F52CD.7080402@arrakis.dhis.org>
References: <423EF2EB.5030505@arrakis.dhis.org> <423F43A8.90005@tiscali.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <423F43A8.90005-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello francois,

Fran=E7ois Valenduc wrote:
| I tried this patch and it doens't work very well. First, the kernel
| takes a very long time to boot. I have to wait more than 30 seconds to
| see the first kernel messages appear.

I've also experienced this initial delay, but mine didn't take AT ALL 30 =
seconds.
5 perhaps but not 30. I'm still trying to figure this out. with me it hap=
pens
immediately at kernel boot. no messages, just a black screen. after a whi=
le, the
kernel boots normally as if it just began booting.

| Second, it takes also a long time
| to load the ac and battery modules. It correctly detects the AC status
| and the presence of the battery. Nevertheless, I can never get the
| battery charge level (or maybe after a too long time and I didn't wait
| enough).

sorry, didn't happen here. this behaviour I could explain with a buggy pa=
tch.
you see, since the latest rich's patch didn't apply, I looked at it and i=
mplemented
the same changes on the current drivers/acpi/ec.c, so I could have ruined=
 it.

basically I switched the lock struct member with a semaphore and replaced=
 every
spinlock call by a corresponding semaphore call.

| Finally, it causes problem with USB support (or maybe only with
| the usblp module). Here below is an extract of dmesg showing the proble=
m:

that's new. I'm just using an usb mouse on the laptop...

| So it seems there is still some work needed to get sbs-cm patch working
| correctly.

indeed. the problem is that I'm not experienced in kernel programming and
rich townsend is currently pursuing another path to support smart-batteri=
es.

thanks for your bug reports. Not sure if I'll be able to help you though.

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > arrakis.dhis.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCP1LNeRy7HWZxjWERAhMIAJ4lR4Xn1ctA+GCWjQyX+Cee6kehgwCg+RHv
hOR2oUDE32Z8g9fCmqe4iQ8=3D
=3D8Jm2
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
