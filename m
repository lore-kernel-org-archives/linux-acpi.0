From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: help troubleshooting
Date: Thu, 8 Sep 2005 10:46:08 +0800
Message-ID: <200509081046.08632.luming.yu@intel.com>
References: <200509071101.27211.johnelliottmartin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200509071101.27211.johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Elliott Martin <johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 08 September 2005 02:01, Elliott Martin wrote:
> Hello,
>
> I just upgraded to the 2.6.13 kernel and I am now seeing new ACPI errors
Could you file a bug on bugzilla.kernel.org ?

> during boot up and I was wondering if I could get some help. I have fixed
> every problem with my DSDT so far, but this is a little more difficult.

What's your DSDT fix?
>
> My question is, how do I find out exactly what is failing from these
> messages:

Please file DSDT on bugzilla.

>
>
>     ACPI-0423: *** Error: Handler for [EmbeddedControl] returned AE_TIME
>     ACPI-1172: *** Error: Method execution failed
> [\_SB_.PCI0.SBRG.EC0_.RWRD] (Node ddfba4e0), AE_TIME
>     ACPI-1172: *** Error: Method execution failed [\_SB_.PCI0.BAT0.BIF1]
> (Node ddfba1a0), AE_TIME
>     ACPI-1172: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BIF]
> (Node ddfba320), AE_TIME
It could be a EC issue. 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
