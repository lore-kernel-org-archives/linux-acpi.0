From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: S3 hangs Sony Notebook
Date: Wed, 12 Nov 2003 00:10:39 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068588639.25527.19.camel@litshi.luna.local>
References: <1068584857.1419.11.camel@garrett.darkzone>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1068584857.1419.11.camel-NZYYv2kObinUTSZfUHD3qA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-11-11 at 23:07, Martin Emrich wrote:
> Hi!
> 
> I'm experimenting with Kernel 2.6.0-test9 + acpi-20031002-2.6.0-test9
> patch on my Sony Vaio PCG-F403 (P3-450, i440BX, PhoenixBIOS, both APM
> and ACPI capable). But I have several problems:
> 
p3 450 sounds a bit old for acpi support but its possible (got a celron
450 hp to work but it needed a new bios).
I have fxa-53 (athelon 1.3G) and acpi works but the dsdt table had to be
replaced due to bugs.
> - I have to use "acpi=force" because otherwise it says my BIOS is too
> old. (Actually, I have the newest BIOS from Sony (dated 2000...*hmm*)
> 
> - reading Battery status works, but it always says "... battery will
> never fully charge", although it charges up to 100%
> 

This is probably since for some reason the battery status is marked as
charging but at 0%, which makes acpi think it will never fully charge
inspite of the fact that it is already charged. Checking how long its
going to take to charge is calculated using a simple formula and acpi
doesn't check its results.

> - When entering S3 state, some lines appear (something about hda, it is
> gone too fast to read), then the screen blanks and the power LED blinks
> red slowly, just like with Suspend-To-RAM in APM mode (which works fine
> btw.). But then I can't turn it on again, neither can I turn it off. I
> have to unplug the PSU and remove the battery to turn it off completely.
> (IIRC somebody posted the same problem with a Dell notebook some time
> ago).
> 

S3 state is very difficult to implement. Most of the work is currently
done on s4 state since its easier to implement.
It will probably be some time before S3 will function properly.
If S4 doesn't work with 2.6 you could try the swsusp version
(swsusp.sourceforge.net) there is an alpha version for 2.6 and a mostly
stable version for 2.4 (a few issues but in most cases stable)

> - Since I'm running ACPI, my system clock does weird things (going
> forward/backward some hours or days - ntpdate is my friend ;-)
> 

Never ran into this problem.
You need to make sure you use hwclock to save system clock to hw be
shutdown/suspend and restore it on resume (should be set up by the
distribution). I don't think acpi should have anything to do with the
clock.

> Most important for me is to get S3 working. Is there any chance?
> Furthermore, what is the best way to test if the different cpu
> throttling settings have any effect at all?
> 

You could probably look at some benchmarking software. There is the
bogomips program (under the sysutils package in debian, don't know about
others). Take note the it gives half the real value on some cpus (I
think at list athelons are a problem but don't remember all of them).

> Thanks
> 
> Martin Emrich
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: ApacheCon 2003,
> 16-19 November in Las Vegas. Learn firsthand the latest
> developments in Apache, PHP, Perl, XML, Java, MySQL,
> WebDAV, and more! http://www.apachecon.com/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
