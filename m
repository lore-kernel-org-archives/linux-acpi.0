From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: 2002-10-22 processor&thermal module broken?
Date: Thu, 24 Oct 2002 21:51:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021024195154.GC8003@poup.poupinou.org>
References: <1035486370.2453.9.camel@coruscant.datenknoten.de> <Pine.LNX.4.44.0210242106010.16976-100000@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210242106010.16976-100000-sxQ525G0OhRQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Cc: ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 24, 2002 at 09:06:45PM +0200, Markus Gaugusch wrote:
> On Oct 24, Sebastian Zimmermann <wegwerf-juni02-XrphxVexwn4ANkabGmIAxw@public.gmane.org> wrote:
> > > Hi,
> > > I just tried 2.4.20-pre11 with latest acpi patch (+ swsusp) and there is
> > > no processor/thermal entry in my /proc anymore. Any hints?
> > Here they are also missing. 2.4.20-pre11-acpi20021022
> > Thermal zone is enabled in config file.
> Are you per chance using gcc 3.2, like me?
> May this be the problem??
> 

I just give it a try.  Do not have anymore processor too (grumble, grumble :)


ducrot@novae:~$ ls -1 /proc/acpi/
ac_adapter
alarm
battery
button
debug_layer
debug_level
dsdt
embedded_controller
event
fadt
info
sleep
thermal_zone
ducrot@novae:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4  (Debian prerelease)

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
