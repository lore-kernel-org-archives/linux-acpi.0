From: Vernon Mauery <vernux-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: bug in acpid scripts
Date: Fri, 23 Jul 2004 13:39:57 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1090615197.9015.7.camel@bluerat>
References: <20040723193658.GA3331@omocha.vort.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040723193658.GA3331-5z3TbH0F9hyr8sbHwu5NIg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Russell Neches <russell-1vnkWVZi4QaVc3sceRu5cw@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-07-23 at 12:36, Russell Neches wrote:
> Tossing an "exit" at the beginning of powerbtn.sh fixes the problem
> (with an obvious trade-ff), and my laptop suspends and resumes
> perfectly. Well, almost perfectly -- I have to unload ohci_hcd before
> shutting down, and I have to figure out how to get wireless working
> after resume, but those are separate issues.
> 
> Is there a sensible way to tell if the system is coming off of S3? I
> imagine I could do something like this to get into S3;

Adding new wakeup devices helps in this area a lot.  Check out the
latest acpi patch to the kernel -- I had this same issue and applied
the  acpi-20040715 patch, which among other things adds support for
other things waking up the machine (sleep button, lid, etc.)

This simply makes it so you don't have to press the power button to wake
up from S3.  While that is not exactly a direct solution, it was the one
I was looking for anyway.

--Vernon



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
