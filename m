From: Pavel Machek <pavel-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Subject: Re: Compaq Presario 2800T update
Date: Thu, 1 Aug 2002 13:06:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020801110614.GE159@elf.ucw.cz>
References: <200207311648.MAA10977@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200207311648.MAA10977-UwFBHNxiom0K2f9UKZ/Dkzyo3AZ8UMn9@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> * Here's the kicker:  swsusp no longer works.  It 
> suspends just fine, but on resume it seems to get 
> caught on the next to last screen during suspend,
> the one that says "Stopping all tasks ... eating
> pages ... freeing pages ..." in ASCII.

Which kernel version?

> If it were not for this last failure I would be quite
> happy.  dmesg is unremarkable.  I took care to make 
> sure that the CONFIG_ACPI_SLEEP=y line is still in 
> the kernel .config.

swsusp does not need CONFIG_ACPI_SLEEP to be YES.
								Pavel
-- 
I'm pavel-7aPAsKgELzg@public.gmane.org "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss-q33YXrgyAoMgsBAKwltoeQ@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
