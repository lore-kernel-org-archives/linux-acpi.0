From: Oscar Pernas <pernas-fdvnYtO25ZEdrSGeuO01YvU/3Eu2kcEP@public.gmane.org>
Subject: Re: semaphore is not ready
Date: Thu, 25 Nov 2004 03:20:58 +0100
Message-ID: <200411250320.58586.pernas@acm.escet.urjc.es>
References: <41A53A81.3060501@paranoici.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41A53A81.3060501-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hello, i had the same problem at the last compilation of 2.6.9. with oss yo=
u=20
have the sound slowly?. I am seeing documentation and i am trying to patch=
=20
the alsa drivers from
      ftp://ftp.alsa-project.org/pub/kernel-patches/
if you discover any news please tell at the list,=20




El Jueves, 25 de Noviembre de 2004 02:50, ultrakorne escribi=F3:
> i am running kernel 2.6.8.1 (ubuntu default)
> on laptop acer tm 4501lci
> I started getting some problems as touchpad that sometimes dont works
> (when ac is plugged at boot i think...)
>
> also tryed to read a video while my laptop was ac plugged and full
> charged... no audio was aviable and i get this error
> codec_semaphore: semaphore is not ready [0x1][0x700100]
>
> i unplugged ac and replugged and audio starts working again (but no
> touchpad)
>
> thx
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
