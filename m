From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: battery information
Date: Tue, 12 Oct 2004 18:49:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <416C0B1E.6090500@pca.it>
References: <20041012135927.1534.qmail@web41125.mail.yahoo.com>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041012135927.1534.qmail-lNMgYVCbVw2A/QwVtaZbd3CJp6faPEW9@public.gmane.org>
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

on 10/12/04 15:59, Paulo da Silva wrote:
>  I have an ACER Aspire 1613Lmi, and I can't get the
> battery be recognized with ACPI. During the boot I get
> the following messages :
> exstore-0300 [1113] ex_store_object_to_ind: Could not
> store object to indexed package element
>  psparse-1133: *** Error: Method execution failed
> [\_SB_.PCI0.LPC0.EC__.GBIF] (Node dfe70480),
> AE_BAD_HEX_CONSTANT
>  psparse-1133: *** Error: Method execution failed
> [\_SB_.PCI0.LPC0.EC__.BAT0._BIF] (Node dfe6fe00),
> AE_BAD_HEX_CONSTANT
> acpi_battery-0146 [1102] acpi_battery_get_info : Error
> evaluating _BIF
> 
> I couldn't find any one who had the same problem. 
I'm not an expert, but it could be something similar to the bug #3005
[1], present ASUS M6N and ATM not yet resolved. The only workaround I
know is Herman's patch [2].

Thx, bye,
Gismo / Luca

[1] http://bugme.osdl.org/show_bug.cgi?id=3005
[2] http://mrhammy2.ath.cx:81/m6n.html
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFBbAseVAp7Xm10JmkRAhdUAJ9KE5UxNYBDJ7HyOo4LtllFqnQvYQCfT9q/
A93DojF8IJrSo38pHKO70CI=
=p8Mq
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
