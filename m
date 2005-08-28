From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: Generic hotkey driver for dock ejecting
Date: Sun, 28 Aug 2005 06:37:51 +0200
Message-ID: <20050828043751.GA7644@tangens.sinus.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC202@pdsmsx403> <20050827235547.GA18990@srcf.ucam.org>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050827235547.GA18990-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  
> It might actually be nice to have an interface that allows userspace to 
> call arbitrary ACPI methods at any time, rather than simply in response 
> to hotkey events.
> 
Hi! 
  Such interface does exist! It's Alex Williamson's  dev_acpi driver, which
loads as a kernel module, and an userspace utility.
I've written a small "acpicall" program based on his own utilities, allowing to
call any method without arguments or with a single integer. BTW, there is
a program called "acpiundock" in his package; did You Try it ? I didn't, 
because I don't have nothing to dock/undock.
  I think that the dev_acpi module is a hot candidate for inclusion to the
kernel tree, it exposes /dev/acpi character device, which interacts with the
ACPI subsystem by ioctls and read/write and allows really nice ACPI space
access.
  It can be found at
  http://free.linux.hp.com/~awilliam/acpi/dev_acpi/dev_acpi-20040803.tar.bz2 ;
I've sent him a patch which registers the driver with sysfs, thus automatically
creating the /dev/acpi node, but he didn't make a new release containing it yet,
I can send it if You want, as well as my experimental acpicall utility source.
                             With regards, Pavel Troller
  
> -- 
> Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
> 
> 
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
