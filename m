From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: HP Omnibook 6100
Date: Mon, 12 Aug 2002 16:02:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020812140247.GC1679@digda.intern.quelltext.com>
References: <slrnalap9u.4tf.andreashappe@imladis.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <slrnalap9u.4tf.andreashappe-r661u5w8kpLX9hvRLAZ2HmZy7eGcjJgl@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Andreas Happe <andreashappe-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andreas!

On Sat, Aug 10, 2002 at 09:10:55PM +0200, Andreas Happe wrote:
> I cannot use ACPI on my Omnibook 6100 (i830m) with 2.4.17 or with
> 2.5.6+. Before 2.5.~16 (if this matters, i could rebuild my kernels to
> verbose this) the kernel booted with a "ACPI subsystem not initialized,
> disabling ACPI" - message, later kernels just go OOPS.

Sorry, but nobody on this list will care about problems you have with
2.4.17 or 2.5.16 kernels -- they are way to old.

Try 2.5.31, or 2.4.18 with a recent patch from http://sf.net/projects/acpi,
or wait a couple of days for the first "official" ACPI patch for 2.4.19
to appear. If those kernels don't work for you, post again to this list
and include your dmesg output along with a description of what goes wrong.

Good luck,
Arndt


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
