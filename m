From: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: [ACPI] Re: 1.1-rc9 acpi_disabled==0x30 on resume
Date: Tue, 30 Sep 2003 08:38:52 +0800
Sender: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309300838.52320.mhf@linuxmail.org>
References: <200309270135.43786.mhf@linuxmail.org> <200309271316.45398.mhf@linuxmail.org> <1064644626.17857.1.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1064644626.17857.1.camel-udXHSmD1qAy4CTf7w+cZoA@public.gmane.org>
Content-Disposition: inline
Errors-To: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 27 September 2003 14:37, Nigel Cunningham wrote:
> My guess would be that the memory is being freed and reused, and that's
> where the 0x30 comes from. Could you use kdb to check it prior to
> suspending?
> 

Manual checking would not be practical, so the script unloads/loads/unloads ac 
prior to suspend and loads it on resume and logs/beeps when failure. 

It last happend with -rc9 but not yet with -rc9D. 

Last time data from the memory dump were remains of an ascii file:

in len */ /* lowowrd last bytes sought */ #define .....

Guess data not initialized on resume, but can't be major or other problems
would pop up.

Regards
Michael



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
