From: Mattia Dongili <dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: bug in acpid scripts
Date: Sat, 24 Jul 2004 15:51:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040724135111.GC2328@inferi.kami.home>
References: <20040723193658.GA3331@omocha.vort.org> <1090673420.4412.14.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-ID: <20040724142159.GE2328-MEqNC12sBsHxa7XIdbXXog@public.gmane.org>
Resent-To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1090673420.4412.14.camel-myFlNLNQP+Q@public.gmane.org>
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

On Sat, Jul 24, 2004 at 01:50:20PM +0100, Matthew Garrett wrote:
> On Fri, 2004-07-23 at 20:36, Russell Neches wrote:
> 
> > My system always enters S3 without complaining, and resumes without
> > complaining. Then it immediately begins a clean shutdown. I had assumed
> > this was caused by general S3 breakage, but the problem is actually
> > caused by acpid catching the power button event that triggered the
> > system to resume. It then dutifully calls powerbtn.sh, and the system
> > shuts down. 
> 
> My current workaround is to make button support modular, and then remove
> the button module during suspend. The power button event then gets
> ignored on wakeup.

You may simply want to stop acpid just before suspending and restarting
it after having resumed.

-- 
mattia
:wq!


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
