From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: Determining Button State
Date: 08 Dec 2002 00:31:44 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1039325504.3240.11.camel@sirius.strandboge.cxm>
References: <3DF2D221.7020005@sympatico.ca>
	 <1039324752.3240.6.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1039324752.3240.6.camel-Ty44UuN9vPJ5T2F9fCU5s856D9/Od9gv@public.gmane.org>
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

On Sun, 2002-12-08 at 00:19, James D Strandboge wrote:
> On Sun, 2002-12-08 at 00:01, Matthew Tippett wrote:
> > Hello,
> > 
> > Looking at rolling out some sort of ACPI script environment for acpid. 
> > Is there any way that the ACPI system determines exposes what state the 
> > subsystem is in.
> > 

>                         # go to X now
>                         /usr/bin/chvt 7         
>          
>                         # restore the keyboard
>                         /sbin/kbdrate -r 30 -d 250 < /dev/console
>                 else
>                         logger -p daemon.info "ACPI lid: lid is closed"
>                         touch $CLOSEDFILE
> 
>                         # go to a tty1 first
>                         /usr/bin/chvt 1         
>      

Though its probably obvious, but all the chvt stuff is for my laptop and
is assuming you are in X first-- which is an ok assumption for me. 
Closing the lid at a console with my script above won't work right.

Jamie

-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
