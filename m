From: Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>
Subject: Re: Tarting up my ACER 1703 ACPI spec
Date: Wed, 14 Jan 2004 21:09:22 -0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4005CC22.9030902@techisa.srv.br>
References: <1073487455.3051.17.camel@dirkl.int.tobit.co.uk> <20040109154007.7c6e4abc.greg@morningdave.org>
Reply-To: erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040109154007.7c6e4abc.greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Greg Sarjeant wrote:

>Hi Dirk,
>
>   I found a couple of HOWTOs about this. They are:
>
>http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt
>http://home.fhtw-berlin.de/~s0502837/r31/
>
>   They suggest that the solution to both of your warnings is to add the following line at the end of the offending methods:
>
>   Return(Package(0x02){0x00, 0x00})
>
>   I can confirm that adding that line to my _WAK method did indeed get rid of the Warning on recompile. I don't know why that is the proper statement, which makes me a little uneasy, so if anyone could explain that (or point me to something that does), I'd appreciate it.
>
>   Hope that helps.
>   Greg
>  
>
I was wondering... has anyone on this list ever thought about making a joint effort and writing some tutorials/articles on ACPI, hosted on a central place? 

Things like a generic explanation on how each ACPI object relates to others, the basic functions needed in a DSDT, how to fix the most common errors (the pages mentioned above already have some good information)... perhaps even some generic code skeletons for thermal zones, fan, etc. Perhaps even a "dissection" of a real DSDT.

I think this could be really useful for the people that are interested in learning more about ACPI and contribute to the project, but are intimidated by the lack of documentation, or excessively technical documentation...


-- 

-- Erico Mendonca
Techisa do Brasil





-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
