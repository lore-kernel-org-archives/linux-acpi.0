From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Sun, 22 Sep 2002 04:31:48 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020922043148.B35@toy.ucw.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <200209192208.40254.jbr.1@gmx.net> <200209192215.g8JMEv306270@pfn1.pefnos> <200209221321.g8MDLb009922@pfn1.pefnos> <20020922005310.B35@toy.ucw.cz> <20020923150937.GA12513@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020923150937.GA12513-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>; from c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org on Mon, Sep 23, 2002 at 05:09:38PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> On Sun, Sep 22, 2002 at 12:53:10AM +0000, Pavel Machek wrote:
> > can we remove /proc/acpi/sleep so users don't waste time trying to make 
> > s3/s4 work in 2.4.x?
> 
> If swsusp is setup, echoing 4 to /proc/acpi/sleep does of course work on
> 2.4.  In addition, 5 can be used to switch off and 1 can be used on some
> machines as well, all with 2.4.x.  How about a syslogged message rather if
> someone tries something with /proc/acpi/sleep that's not supported?

Do you think you could produce patch to do just that? printk() on S4 if
not config_software_suspend and printk() on S3 under 2.4.X is the best way
to go. Unfortunately I do not have 2.4.X tree easily available...
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
