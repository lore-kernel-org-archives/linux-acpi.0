From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: [REGRESSION] 'pciehp' stops working since 2.6.10-rc2
Date: Tue, 28 Dec 2004 14:51:48 +0100
Message-ID: <41D164F4.9080407@pca.it>
References: <16A54BF5D6E14E4D916CE26C9AD30575E0068B@pdsmsx402.ccr.corp.intel.com>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575E0068B-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

on 12/28/2004 02:23 AM, Li, Shaohua wrote:
> PCIEHCP is for PCI-E hotplug. Does T42p support PCI-E?
I supposed this, but I don't know at all if T42p support PCI-E. I guess
yes, as the module 'pciehp' is automatically loaded by hotplug at boot
on both kernel (Debian 2.6.8-1 and custom 2.6.10), so, I think that even
if there's no possibility to use the PCI-E hotplug, there's a controller
or something similar in the T42p.

How can I know by sure what I just wrote? I can provide my DSDT if
necessary.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD4DBQFB0WT0VAp7Xm10JmkRAgX8AJdbKd8bd6ayytARw6YIn97h14DAAJ9ErOGj
Sz7mEGmcZcLPVP79oB9aCA==
=6Hz6
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
