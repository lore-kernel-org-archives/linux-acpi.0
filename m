From: Michael Frank <mhf-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: [ACPI] Re: 1.1-rc9 acpi_disabled==0x30 on resume
Date: Sat, 27 Sep 2003 13:19:36 +0800
Sender: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309271313.28366.mhf@linuxmail.org>
References: <200309270135.43786.mhf@linuxmail.org> <1064606502.5722.2.camel@laptop-linux> <20030927000908.GB8008@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030927000908.GB8008-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Content-Disposition: inline
Errors-To: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday 27 September 2003 08:09, Karol Kozimor wrote:
> Thus wrote Nigel Cunningham:
> > Hi.
> > 
> > In arch/i386/kernel, acpi_disabled is declared __init_data. If you
> > remove that attribute, is the issue fixed?
> 
> I believe the patch is already merged. I wonder how could this bug be 
> present for that long without anyone noticing...
> Best regards,
> 

Well, I "use" swsusp actively in a portable application only since -rc9, 
and did not use ACPI modules for stress testing.

I wrote s script which loads ACPI ac module and reads the state. When 
online, it starts all the office stuff such as network, nfs... 
and found out when ac refused to load. Then I remembered something about
acpi being disabled on resume and had a look with kdb...

Regards
Michael




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
