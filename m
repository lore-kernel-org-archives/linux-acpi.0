From: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Subject: Re: 2.6 won't poweroff
Date: Wed, 26 May 2004 21:57:11 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040527015711.GA2951@smeagol>
References: <20040525044514.GC2217@smeagol> <16563.119.414292.134855@aber.ac.uk> <20040526043252.GF2576@smeagol> <1085622000.3503.10.camel@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1085622000.3503.10.camel-4/PLUo9XfK8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, May 27, 2004 at 02:40:01AM +0100, Sérgio Monteiro Basto wrote:
> 1- Have you configure Power Management support on yes (CONFIG_PM=y) ?

Yes.

> 2- you use poweroff command or shutdown -h now ? poweroff can have
> better results (I think).

I've tried both.

> 3- no longer have to worry about compile w/ or w/o APIC because you
> should have same results if you use "nolapic" on boot options, or not
> use.

I'm not sure if it's because it's been cooler out, or because I recompiled
without APIC however...I'm no longer getting the random freezes that I was
before. Either way I won't be putting APIC back in, just in case. :)

emma

-- 
Emma Jane Hogbin
[[ 416 417 2868 ][ www.xtrinsic.com ]]


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
