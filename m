From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: ACPI with P4 mainboard
Date: Thu, 19 Dec 2002 15:32:21 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021219153221.GB14703@clara.net>
References: <4.3.2.7.2.20021219152505.00b54d00@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021219152505.00b54d00-KvFWrsCPMkLbFfAX06+HdQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Margit Schubert-While <margitsw-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Margit Schubert-While [margitsw-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org] wrote:
> 	1)	Didn't think that a P4 < 3.06Ghz had HT  :-)

There are Xeons which do.

> 		<6>ACPI: Processor [CPU1] (supports C1, 8 throttling states)
> 		<6>ACPI: Processor [CPU2] (supports C1, 8 throttling states)
> 
> 	2)	There is nothing in "fan" and "thermal_zone". I suspect that 
> 	the DSDT
> 		lacks this info.

That's usually the reason.  Run your dsdt through iasl to disassemble it
and see if there are errors.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

Your job is being a professor and researcher: That's one hell of a good excuse
for some of the brain-damages of minix.
	-- Linus Torvalds to Andrew Tanenbaum


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
