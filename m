From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH][RFC] Add C3 support to P4-M / ICH-M chipsets
Date: Mon, 24 May 2004 12:11:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040524101130.GB4387@poupinou.org>
References: <20040518211431.GA17545@hell.org.pl> <1085110450.12353.553.camel@dhcppc4> <20040521180155.GP29214@poupinou.org> <20040521194205.GA25863@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040521194205.GA25863-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 21, 2004 at 09:42:05PM +0200, Karol Kozimor wrote:
> Thus wrote Bruno Ducrot:
> > IIRC, there is trouble with C3 on a ICH3m, though I do not remember
> > exactly if that is true.  I will look at the specs update.
> 
> As far as I remember, the only one was when running IO-APIC and it affected
> both C2 and C3. Most BIOSes already disable APIC on laptops, and those that
> don't probably still use C2, so the patch doesn't really change anything
> with respect to them.

Sound like you are correct.  For the patch itself though, there is at
least those troubles:
- There is systems where you really don't support bus master
arbitration.
- you assume that DIS_ARB is at PMBASE + 0x20, which is true only
for a subset of chipsets.  Actually, there are more for which it's at
0x22 I believe (and this is not an offset relative to PMBASE).

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
