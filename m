From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Compaq 1700, 2.4.18, acpi-7,24 - SUCCESS (I think)
Date: Fri, 16 Aug 2002 10:58:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020816085840.GD10248@poup.poupinou.org>
References: <15706.48376.457358.298696@chaos.crhc.uiuc.edu> <Pine.GSO.4.21.0208142004370.16304-100000@sediment.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208142004370.16304-100000-Bq+f90TzBY23n+kRt3O4EA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Prabhakar Reddy Gudla Venkata Siva <reddyg-3+M4TpyeDAP2fBVCVOL8/A@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 14, 2002 at 08:18:23PM -0400, Prabhakar Reddy Gudla Venkata Siva wrote:
> Hi list,
> 
> Graham, nice to see that I am not all alone :) I too have the same status
> with the acpi-20020726 patch on a similar model (mine is 1720US).
> 
> However, my kernel just keeps repeating "schedule_task(): kevent has not
> started" after the alleged two "PCI Interrupt Link enabled" statements. It
> never freezes.

The only case I see for such bug (the schedule_task(): kevent...) is to
call osl::acpi_os_queue_for_execution(), but keventd is not started
at this stage.  I think that one _STA function, or one _INI function
did a 'Notify', so that osl::acpi_os_queue_for_execution() is called.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
