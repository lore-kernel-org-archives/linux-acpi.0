From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI HOWTO
Date: 20 May 2004 23:11:16 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085109076.12349.535.camel@dhcppc4>
References: <20040517190137.GD5547@smeagol>  <40A95511.3070109@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40A95511.3070109-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Cc: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-05-17 at 20:13, John Belmonte wrote:

> It may be that when you started with ACPI, there was a large gap between 
> ACPI development work and kernel releases.  From my understanding, these 
> days, the 2.4 and 2.6 kernels use the same ACPI system, and improvements 
>   by the ACPI team show up rather quickly in the kernel, especially the 
> 2.6 series.  I'm sure others on this list are more qualified to talk 
> about this than I am.

Emma,
It would be fair to call ACPI on Linux an "emerging technology", and
bugs are being fixed at a rapid rate.  For this reason I do agree that
step 1 should be to run the most recent kernel that is practical.

Note that we support the latest ACPI code on 2.4 and 2.6; both the
latest released kernel and the kernel under development. eg.

2.6.7 (develpment)
2.6.6 (released)

2.4.27 (development)
2.4.26 (released)

The ACPI patch gets absorbed into the development trees about every 5 to
10 days.  We try to make these updates as frequent as practical so that
the ACPI patch never grows too big.

As the released trees are no longer accepting patches, the ACPI patch
for the grows monatonically, but then gets deleted when the development
tree gets released and a new development tree is created.  This is to
encourage users to run (and test;-) the latest kernels.

Also, before any ACPI bugs are reported, it is best to verify that the
machine is running the latest BIOS from the vendor.
The better vendors are actually quite good about releasing BIOS fixes
for systems in the field.

For a number or reasons, I am not a big advocate of running patched
DSDTs -- my view in this area is that is a debugging tool, and that we
should either fix Linux to handle the BIOS, or the BIOS should be
corrected by the vendor.

thanks,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
