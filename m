From: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Subject: Re: Thinkpad R32 2.5.65-acpi
Date: Mon, 24 Mar 2003 14:00:25 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303241900.h2OJ0PR18532@throb.netspace.org>
References: <F760B14C9561B941B89469F59BA3A84725A21E@orsmsx401.jf.intel.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: Your message of "Mon, 24 Mar 2003 10:37:24 PST."
             <F760B14C9561B941B89469F59BA3A84725A21E-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Lu's hack fixes this.
I can look at it more closely if you want to try to get a real fix(tm).

Many more things seem to work, and there are no error messages.

osl-0912 [70] os_wait_semaphore     
	 : Failed to acquire semaphore[cff62580|1|0], AE_TIME
utmisc-0743 [69] ut_acquire_mutex      
	 : Thread 0 could not acquire Mutex [ACPI_MTX_Events] AE_TIME

When I close the lid or push the "Thinkpad" button.  Interestingly,
even though I get this error message when I hit the bightness buttons,
I can adjust the brightness.



How do I test sleeping?  The sleeping button doesn't seem to do anything.

--
Hello, Justice Department?  I'd like to report a subversive penguin.  
  --Tom Tomorrow "This Modern World"
Brian Perkins                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
