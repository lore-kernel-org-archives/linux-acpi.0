From: Thomas Andrews <tandrews-Dza9YrynN5pWaveUIWBRJg@public.gmane.org>
Subject: Re: Starting AML
Date: Sat, 1 May 2004 11:23:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040501092338.GA17352@gaspode.nextlink.co.za>
References: <20040429192133.GI28420@gaspode.nextlink.co.za> <4091F662.EF7F0B1C@monetplus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4091F662.EF7F0B1C-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 30, 2004 at 08:46:58AM +0200, Zden?k OGAR Skal?k wrote:

> I have Compar Armada 109 and I already patched few DSDT for Compaq
> notebooks as Armada 110, Evo N110, Evo N800c and similar (they are
> nearly the same :-).  The symptons were the same - lot of syntax
> compile errors, off-by-one error, battery status not reading
> properly, ..... You could try to search this list for messages from
> me and try to repare yourself, or you could send me you dsdt and I
> will try :-)

Thanks Zdenek, I *really* appreciate your offer! I tried to search the
SF archives, but had no luck. Before I bother you to look at it, I
woould like to make some attempt myself though :)

I just need a hint about where to start looking. Could you perhaps send
me your original DSDT plus the patch/diff file with your fixes. If I can
work my way through that, I should be able to grok mine hopefully.

> As for debuging DSDT, you could you DSDT's debug facility, ex:
> Store("Some text you want to be printed",Debug)

Thanks. I assume the output just goes to dmesg ?

-Thomas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
