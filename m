From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Patching 2.6.9 for custom DSDT
Date: Fri, 22 Oct 2004 12:03:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4178DAE7.6010005@pca.it>
References: <8d158e1f041022020763faf71a@mail.gmail.com>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8d158e1f041022020763faf71a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 10/22/04 11:07, Patrick Ale wrote:
> I'd like to try the custom Acer Aspire 1703 DSDT found on the acpi.sf.net site.
> 
> in drivers/acpi/osl.c I see the folloiwing
> 
> #ifdef CONFIG_ACPI_CUSTOM_DSDT
> #include CONFIG_ACPI_CUSTOM_DSDT_FILE
> #endif
> 
> 
> Does this mean I can add the following to the top of the c file?
> 
> #define CONFIG_ACPI_CUSTOM_DSDT_FILE "/path/to/dsdt.file"
> #define CONFIG_ACPI_CUSTOM_DSDT
no, you should configure
	make [config|menuconfig|xconfig]

your kernel to use a custom DSDT. The voice is

 - Power management otions (ACPI, APM)
   - ACPI ([...])
     - Include Custom DSDT
       - Custom DSDT Table file to include
         /path/to/dsdt.file

NB, the DSDT should be in the AmlCode declaration.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBeNrmVAp7Xm10JmkRAjnoAJ4mbdstsLABos+ib78gcQgB59evJACcDx6f
HbKKuQQ+i9JlncV3/kRZJZI=
=Q0am
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
