From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: dell inspiron 8600 not working
Date: Fri, 16 Jul 2004 19:26:03 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040716172603.GY6326@poupinou.org>
References: <20040716110537.GA4398@localhost> <20040716152439.GX6326@poupinou.org> <20040716162524.GC5541@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040716162524.GC5541-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Spike Spiegel <debianix-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 16, 2004 at 06:25:24PM +0200, Spike Spiegel wrote:
> It was a dark and stormy night on 2004/07/16 when I heard Bruno Ducrot yelling:
> 
> [cut]
> > If really what you need is suspend/resume especially on a 2.4 kernel,
> > you may want to test if APM work better for you.  
> 
> uhm, thought APM wasn't supported anymore by this BIOS.
> 
> >2.4 kernels do support
> > only S1 and S4bios (and maybe S4 via some patches), but AFAIK,
> > developpers loose interrest to support those functionnality in a 2.4
> > kernel, and those S1 and S4bios are likely unstable under 2.4.
> 
> ok, guess I'll try to upgrade in a little while, I really need susped to
> disk.
> 
> Could you please point me somewhere I can read about required steps
> to get S4 working on 2.6?

If your only need is S4, you should try
http://softwaresuspend.berlios.de/
which have been reported to work pretty well with 2.4 kernel also..

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
