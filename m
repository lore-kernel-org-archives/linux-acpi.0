From: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH] fix IRQ / GPEs restore on wake
Date: Fri, 30 Apr 2004 22:12:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4092B319.8070902@free.fr>
References: <37F890616C995246BE76B3E6B2DBE05571657B@orsmsx403.amr.corp.intel.com> <4092ADEF.2000505@free.fr> <20040430195701.GA10958@hell.org.pl>
Reply-To: eric.valette-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040430195701.GA10958-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, a.malysh-1WJ9BOJEYl0b1SvskN2V4Q@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor wrote:
> Thus wrote Eric Valette:
> 
>>Moore, Robert wrote:
>>
>>>The next version of ACPI CA will better manage wake vs. run vs. wake/run
>>>GPEs and may handle this correctly without the change below.
>>>
>>>Bob
>>
>>OK. This was fair enough but as I have tried 2.6.6-rc3-mm1 that contains:
>>
>>ACPI: Subsystem revision 20040326
> 
> 
> I guess Robert meant post-20040326...
> Best regards,
> 

I misread the date, I just _really_ saw 20040426 :-( When will we be 
able to test something to see if the bug is really gone or not? Should I 
really get files directly from ACPI tree via bitkeeper?

At least this served to complete the bug description with an updated 
patche and to record the explanation by original author...

Sorry for the trouble,

-- eric




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
