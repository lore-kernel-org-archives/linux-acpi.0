From: Joshua Legbandt <jtlegbandt-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: Re: [20030321] Failed to acquire semaphore
Date: 23 Mar 2003 19:30:23 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1048476623.3112.2.camel@suburbia>
References: <20030323203025.GA13039@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030323203025.GA13039-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2003-03-23 at 12:30, Karol Kozimor wrote:
> Mar 23 20:12:30 nadir kernel:      osl-0888 [24] os_wait_semaphore     : Failed to acquire semaphore[cfff74c0|1|0], AE_TIME
> Mar 23 20:12:30 nadir kernel:   utmisc-0743 [23] ut_acquire_mutex      : Thread 0 could not acquire Mutex [ACPI_MTX_Events] AE_TIME
> #v-
> 
> Occasionally (e.g. upon a notify or event), the two last lines reappear,
> and ACPI events are not handled otherwise (i.e. acpid fails to notice
> them). 

I am seeing the same issue with 2.4.21-pre5, the 20030321 acpi patch and
no other patches. Since I run this on my laptop, my question is whether
this is going to negatively affect the lifespan of my laptop. On the
other hand, now even with the power plugged in my battery is always
recognized...

-Josh

-- 
Joshua Legbandt <jtlegbandt-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
