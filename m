From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: S3 resume problems on HP compaq nc4010
Date: Mon, 10 May 2004 02:19:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040510001943.GC9213@message-id.gmane0305.slipkontur.de>
References: <1083777804.4093.71.camel@descent.netsplit.com> <20040509015516.GA5487@elf.ucw.cz> <1084117826.2372.32.camel@syndicate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1084117826.2372.32.camel-ImmFMecdQhGzQB+pC5nmwQ@public.gmane.org>
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

On Sun, May 09, 2004 at 04:50:26PM +0100, Scott James Remnant wrote:
> On Sun, 2004-05-09 at 03:55 +0200, Pavel Machek wrote:

> > > This seemed like the most likely place to bring up my ACPI woes :)  I've
> > > recently purchased an HP compaq nc4010 (it's mostly identical to the
> > > nc4000) and haven't been able to get ACPI S3 (memory) suspend
> > > working.
> > 
> > Does ACPI S4 work for you? Try that first, its easier.
> > 
> Nope, swsusp does actually resume the keyboard and screen but then locks
> up.  pm-disk doesn't even suspend.

Even with init=/bin/bash? I have reports from people successfully using
swsusp on an nc4000.
Please elaborate "does actually resume the keyboard and screen", what does
it print before locking up? Do you have $VENDOR-agp loaded? Which kernel
version?
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
