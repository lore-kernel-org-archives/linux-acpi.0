From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: RE: thermal.o Linux ACPI Kernel Modul
Date: Thu, 16 Jan 2003 12:35:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030116113524.GS12516@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847137F73@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847137F73-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: fat32-S0/GAf8tV78@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 15, 2003 at 05:19:59PM -0800, Grover, Andrew wrote:
> > From: Daniel [mailto:Fat32-S0/GAf8tV78@public.gmane.org] 
> > Hallo Andrew,
> > I have a little problem getting my cpu fan to work proppably 
> > with linux.
> > The ACPI module you coded creates a file in the proc fa calle 
> > "trip_points".
> > When I cat this file I get the following:
> > cat trip_points
> > critical (S5):           85 C
> > passive:                 95 C: tc1=2 tc2=5 tsp=300 devices=0xc12c7680
> > 
> > So my fan is running the hole time (sometimes slower, 
> > sometimes faster, but 
> > never realy stops). btw. I have a Acer 613TXC Notebook with 
> > Phoenix BIOS 
> > (latest version).
> 
> You will notice that your system does not have an "active" entry. This
> generally means that the fan is not under ACPI's control. So, the OS
> power policy can read the temp (what does your temperature read?) and
> implement passive cooling (throttle the CPU) and may shut the system
> down when the temp hits 85C (wow, pretty hot) but it doesn't know about
> any active cooling mechanisms.

passive at 95 and critical at 85 ?!  Oh my..

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
