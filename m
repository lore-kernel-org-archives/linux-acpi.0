From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: does cpu_idle() halt CPU?
Date: Sat, 29 Mar 2003 14:47:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030329134742.GD10287@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847E96D88@orsmsx401.jf.intel.com> <20030328150218.D10287@gateway.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030328150218.D10287-Ht5ggzGNZTC9Yl/XQThFG6xOck334EZe@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jun Sun <jsun-vWJf10E4RRusTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 28, 2003 at 03:02:18PM -0800, Jun Sun wrote:
> On Fri, Mar 28, 2003 at 02:43:32PM -0800, Grover, Andrew wrote:
> > 
> > Your system either doesn't support C3, or the constant bus master
> > activity is keeping it out of C3. USB can cause this, but also AC97.
> >
> 
> No USB and AC97.  Have 802.11 card working.  Not sure if this matters.

Who knows..

> 
>  
> > > > - What does the ACPI: Processor line say in your dmesg say?
> > 
> > There should be a line that says, "ACPI: Processor found (x perf states
> > y throttle)" Is that there? It may be occurring later on in the boot
> > process.
> >
> 
> I found this line:
>  
> ACPI: Processor [CPU0] (supports C1 C2 C3, 2 performance states)
> 
> > > > What kind of laptop do you have? Does it support SpeedStep, 
> > > PowerNow, or
> > > > the like?
> > > 
> > > My laptop is Fujitsu S6110.  CPU supports speedstep.
> > 
> > Getting into the lowest SpeedStep state will help battery life. You may
> > want to investigate the cpufreq project.
> > 
> 
> So my previous conclusion about C1/C2 not saving power is right?
> 

No.  C2 will give you some power saving (try to disable explicitely and
you will see a decrease of the battery life).

You forgot at least disk activities especially if ext3, which
prevent almost all IDE drivers to go to idle state.
But that will not explain why you can not go to C3 though.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
