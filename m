From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Problem with reading /proc/acpi/battery/BAT1/info
Date: Mon, 18 Nov 2002 14:55:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021118135554.GF691@poup.poupinou.org>
References: <20021118131632.1eaf9cc1.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021118131632.1eaf9cc1.hanno-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 18, 2002 at 01:16:32PM +0100, Hanno Böck wrote:
> There seems to be a problem that on some laptops, reading
> /proc/acpi/battery/BAT1/info
> takes very long and freezes the system in that time.
> 
> This is a problem with the gnome battery applet (battstat). See bug:
> http://bugzilla.gnome.org/show_bug.cgi?id=88553
> 
> >Reading /proc/acpi/battery/BAT1/info freezes my laptop
> >(Dell Inspiron 8k, BIOS A19) for some milliseconds every
> >time battstat-applet-2 updates its view, so I patched
> >acpi-linux.c that it would only read this file once.
> 
> As people reported to me, this also happens with the latest ACPI-Patch.
> Is this an issue that can be fixed on the kernel-side? This would help us a lot, because all workarounds we have would introduce new problems.
> 

Anyway, polling /proc/acpi/battery/*/info is IMHO a bad idea.  You
should read those files at init time, then reload only when you receive
notifications of batteries changes.

Well.  It is 'simple' to state that, but probably harder to implement.
There is actually two daemons (acpid and ospmd, depending if you choose
'stable' wrt 'devel').
With ospmd, you should then use the library provided in order to
receive the notification needed in order to reload the info files, or
best use the provided library in order to get all the needed information
for the batteries.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
