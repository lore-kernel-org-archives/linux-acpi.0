From: "Daniel Solsona Moratiel" <dani-fQczH/8Hd3rnGZpH1ro7E16hYfS7NtTn@public.gmane.org>
Subject: Re: DSDT Problems with Acer Aspire 1691WLMi
Date: Fri, 3 Jun 2005 16:32:14 +0200 (CEST)
Message-ID: <52930.80.58.36.44.1117809134.squirrel@80.58.36.44>
References: <1117711110.7363.9.camel@localhost.localdomain>	
    <429F1315.80600@altern.org>
    <1117791345.7363.18.camel@localhost.localdomain>
    <42A0404F.4040207@altern.org> <42A05F70.6040907@suse.de>
Reply-To: dani-fQczH/8Hd3rnGZpH1ro7E16hYfS7NtTn@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42A05F70.6040907-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: DJAX <djax-whniv8GeeGkdnm+yROfE0A@public.gmane.org>, ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Daniel Solsona <dani-fQczH/8Hd3rnGZpH1ro7E16hYfS7NtTn@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>> You must have ACPI_INITRD=3Dy in your /usr/src/linux/.config ( or
>> /proc/config.gz if you have enable CONFIG_IKCONFIG_PROC=3Dy)

I'll need to check that, I'm not sure if I have that enabled


>> I put my DSDT.aml in my initrd.img that way:
>> ----------------8<----------------
>> DSDT=3D/boot/DSDT.aml
>>
>> cp initrd.img-2.6.11 initrd.img-2.6.11-ACPI
>> echo -n "INITRDDSDT123DSDT123" >> initrd.img-2.6.11-ACPI
>> cat $DSDT >> initrd.img-2.6.11-ACPI
>> echo -n "INITRDDSDT321DSDT321" >> initrd.img-2.6.11-ACPI
>> ---------------->8----------------

Yes, I did that.

>>
>> In a verbose dmsg, you get something like:
>> ----------------8<----------------
>> ACPI: Looking for DSDT in initrd... found (at offset 4788244)!
>>  found customized DSDT with 27352 bytes!
>> ---------------->8----------------
>>
>> CONFIG_ACPI_DEBUG has to be enable to have this message.

Will check it too.

> Be aware that this won't work with a plain vanilla kernel.
> You'll need the DSDT in initrd patches from:

Yes, I'm using kubuntu hoary, and I read that it has the patches on the
kernel already.

Thanks all for the help, gonna check that when I have some time.



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
