From: Francesco Mosca <fmosca-oCUIoMTM22Q@public.gmane.org>
Subject: Re: asus am1354d WORKS!
Date: 24 Oct 2002 21:14:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1035486867.644.3.camel@sputnik>
References: <1035228143.7587.3.camel@sputnik>
	<20021023105406.GC604@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021023105406.GC604-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Il mer, 2002-10-23 alle 12:54, Ducrot Bruno ha scritto:
> On Mon, Oct 21, 2002 at 09:22:19PM +0200, Francesco Mosca wrote:
> > well, i've finally got acpi working, using the latest
> > 2.4.20-pre8+acpi20021002
> > 
> > all IRQs seem to be ok, thermal zone seems to work. the only thing is
> > that if i echo 1 > /proc/acpi/sleep nothing happens..
> > 
> 
> Does your notebook support S1 ? (basically, what say 'cat /proc/acpi/sleep')

seems not..

sputnik:~$ cat /proc/acpi/sleep
S0 S3 S4 S5 

but..

win2k presents me with the options for "standby", "suspension" and
"poweroff", all of them working right. doesn't "standby" stand for
"sleep"? or am i missing something?

thanks for your help

Francesco




-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
