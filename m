From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: PROBLEM/FIX: ACPI break USB detection on i386 (linux-2.4.22)
Date: Wed, 3 Sep 2003 21:00:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309032100.58361.adq_dvb@lidskialf.net>
References: <mnet2.1062612354.26146.pinotj@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <mnet2.1062612354.26146.pinotj-fBIn7JHAfCbUKx/7vDf7Bw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pinotj-fBIn7JHAfCbUKx/7vDf7Bw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 04 Sep 2003 12:05 am, pinotj-fBIn7JHAfCbUKx/7vDf7Bw@public.gmane.org wrote:
> Hi,
>
> My first bug report, be gentle ;-)
>
> [1.] PROBLEM/FIX: ACPI break USB detection on i386 (linux-2.4.22). Include
> a fall-back patch

As you say, its a fallback diff. Effectively its reverting to the original 
behaviour.. It won't work on (say) the nforce2 chipset, but it at least gets 
you working.

Can you send me some docs so I can try and fix the problem in the main code 
please?

I need:
/proc/acpi/dsdt
Failed dmesg output
Successful dmesg output

I see its a SiS chipset... can you give me details on the precise chipset and 
motherboard



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
