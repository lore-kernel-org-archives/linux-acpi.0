From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Centrino question
Date: Wed, 26 May 2004 01:56:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040525235610.GA21791@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F8404622C57@PDSMSX403.ccr.corp.intel.com> <20040520015748.776d5b84.neurowork@free.fr> <1085111429.12352.563.camel@dhcppc4> <20040521125637.33f69fc6.neurowork@free.fr> <20040521115207.GA12775@hell.org.pl> <1085161136.9856.5.camel@Neuromancer.home.net> <1085527691.9167.39.camel@dorker.boxed.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1085527691.9167.39.camel-x1HDAq6LUf79HyLP1LL8ZA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>
Cc: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Alexander Hoogerhuis:
> I've been through tracking down what disables C3 on my laptop (HP
> nc6000). It all happens when the uhci-hci USB drviver goes in. When I
> queried about it on lkml a while back it was due tro some support
> lacking in the UHCI dirvers as of yet.

Whenever something is plugged into the controller, bus mastering kicks in
and C3 is effectively disabled, also on Windows. This is, to my best
knowledge, a limitation of the USB interface itself. As far as I know, at
least uhci-hcd driver in 2.6 suspends the controller when nothing is
plugged in, thus allowing to use C3. The situation might be different under
2.4.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
