From: DJAX <djax-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Subject: Re: DSDT Problems with Acer Aspire 1691WLMi
Date: Fri, 03 Jun 2005 13:34:39 +0200
Message-ID: <42A0404F.4040207@altern.org>
References: <1117711110.7363.9.camel@localhost.localdomain>	 <429F1315.80600@altern.org> <1117791345.7363.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1117791345.7363.18.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Daniel Solsona <dani-fQczH/8Hd3rnGZpH1ro7E16hYfS7NtTn@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Daniel Solsona a =E9crit :

>Ok, I got a version of iasl taht compiled with no errors the custom dsdt
>that I got from acpi.sourceforge
>
>I put it on initrd as I read somewhere and restarted computer after
>changing grub menu to get the new initrd.
> =20
>
You must have ACPI_INITRD=3Dy in your /usr/src/linux/.config ( or
/proc/config.gz if you have enable CONFIG_IKCONFIG_PROC=3Dy)

I put my DSDT.aml in my initrd.img that way:
----------------8<----------------
DSDT=3D/boot/DSDT.aml

cp initrd.img-2.6.11 initrd.img-2.6.11-ACPI
echo -n "INITRDDSDT123DSDT123" >> initrd.img-2.6.11-ACPI
cat $DSDT >> initrd.img-2.6.11-ACPI
echo -n "INITRDDSDT321DSDT321" >> initrd.img-2.6.11-ACPI
---------------->8----------------

In a verbose dmsg, you get something like:
----------------8<----------------
ACPI: Looking for DSDT in initrd... found (at offset 4788244)!
 found customized DSDT with 27352 bytes!
---------------->8----------------

CONFIG_ACPI_DEBUG has to be enable to have this message.

Else I know that it's my DSDT when I can see the battery state.

>But there is no change, I have the same problems as before. There is any
>way I can confirm that the new dsdt is loaded correctly? maybe getting
>dsdt from /proc/acpi/dsdt, decompiling and seeing if its the same as the
>custom dsdt?
> =20
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22=
005
