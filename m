From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: [PATCH] filling in ACPI method access via sysfs namespace
Date: Thu, 6 May 2004 12:02:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040506100210.GA194@elf.ucw.cz>
References: <1081453741.3398.77.camel@patsy.fc.hp.com> <1081549317.2694.25.camel@patsy.fc.hp.com> <4077535D.6020403@neggie.net> <1081566768.2562.8.camel@wilson.home.net> <407786C6.7030706@neggie.net> <1081629776.2562.40.camel@wilson.home.net> <1081653618.2562.52.camel@wilson.home.net> <20040411222940.GJ18329@parcelfarce.linux.theplanet.co.uk> <1081740686.1715.20.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1081740686.1715.20.camel-/d9U08IjUQs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > It seems unintuitive that you have to read the file for the method to
> > take effect.  How about having the write function invoke the method and
> > (if there is a result) store it for later read-back via the read function?
> > It should be discarded on close, of course.  A read() on a file with
> > no stored result should invoke the ACPI method (on the assumption this
> > is a parameter-less method) and return the result directly.  Closing a
> > file should discard any result from the method.
> 
>    How's this?  It behaves the way you described, but might be doing
> some questionable things with the buffer to get there.  Is there a
> better place to store the return data than back into the buf passed to
> write() (aka file->private_data)?  Without adding callbacks to
> open/close, I'm not sure how else we can dispose of the results on
> close.  Thanks,


> +	/*
> +	 * For convenience, handle cases where the last argument
> +	 * is too small.
> +	 */
> +	count = length / sizeof(union acpi_object);
> +	if (length % sizeof(union acpi_object))
> +		count++;
> +
> +	if (count) {
> +		size = sizeof(struct acpi_object_list) +
> +		       ((count - 1) * sizeof(union acpi_object *));

This probably makes it *way* too implementation dependand.
								Pavel
-- 
When do you have heart between your knees?


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
