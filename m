From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Compaq 1700, 2.4.18, acpi-7,24 - SUCCESS (I think)
Date: Mon, 19 Aug 2002 10:42:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020819084240.GA16978@poup.poupinou.org>
References: <20020816085840.GD10248@poup.poupinou.org> <Pine.GSO.4.21.0208161730480.24869-100000@sediment.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208161730480.24869-100000-Bq+f90TzBY23n+kRt3O4EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Prabhakar Reddy Gudla Venkata Siva <reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 16, 2002 at 05:32:21PM -0400, Prabhakar Reddy Gudla Venkata Siva wrote:
> Hi Bruno,
> 
> So what is the solution for the problem ? Do u have any ?

I have no time to search a solution for this problem:  I have
a job that take me all my time (even the parse one...), but I think that
I can work for something for this trouble when I will have more sparse time
to spend in one or two week.

> 
> <snip>
> > > However, my kernel just keeps repeating "schedule_task(): kevent has not
> > > started" after the alleged two "PCI Interrupt Link enabled" statements. It
> > > never freezes.
> 
> <snip> 
> 
> > The only case I see for such bug (the schedule_task(): kevent...) is to
> > call osl::acpi_os_queue_for_execution(), but keventd is not started
> > at this stage.  I think that one _STA function, or one _INI function
> > did a 'Notify', so that osl::acpi_os_queue_for_execution() is called.
> > 
>  
> 
> -- 
> Reddy
> 

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
