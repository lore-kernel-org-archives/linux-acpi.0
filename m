From: "Hyung K. Kim \(±èÇü±Ô\)" <hyungkk-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Vaio Battery
Date: Mon, 12 Aug 2002 07:30:04 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020812143004.17996.qmail@web11108.mail.yahoo.com>
References: <20020811090120.GC806@fmi.uni-passau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020811090120.GC806-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: M G Berberich <berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have a similar situation.  I just decided the live
with it by hacking the battstat_applet to hard code
those values.  I also noticed that My laptop locks up
after a while of running the battstat_applet, so I
changed to code to not even read the info file.
(/proc/acpi/battery/CMB0/info)

It seem to have fixed the lock up problem.

HK


--- M G Berberich <berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org> wrote:
> Hello,
> 
> On 2002-08-06 16:04, Jacques GANGLOFF wrote
> > On 2002-08-04 16:45, Jacques GANGLOFF wrote
> > >
> > > I tried the latest acpi patch with a 2.4.18
> kernel on a VAIO FX
> > > 702. I runs quite smoothly but I have a little
> problem that prevents
> > > akpi (battery monitor) to work properly.
> > > 
> > > The result of cat /proc/acpi/battery/BAT1/info
> is :
> > > 
> > > present:                 yes
> > > design capacity:         5 mWh
> > > last full capacity:      5 mWh
> > > battery technology:      rechargeable
> > > design voltage:          14800 mV
> > > design capacity warning: 400 mWh
> > > design capacity low:     384 mWh
> > > capacity granularity 1:  64 mWh
> > > capacity granularity 2:  64 mWh
> > > model number:            BAT1
> > > serial number:
> > > battery type:
> > > OEM info:
> > > 
> > > I suppose that the design capacity and the last
> full capacity are
> > > wrong, like the model number, serial number,
> battery type and OEM
> > > info.
> >
> > which is apparentky the default initialization of
> the variable PBIF
> > (see below).
> > So the question is: why PBIF is not altered when
> calling the method
> > _BIF ?
> 
> exactly the same here with a Sony Vaio FX502.
> 
> 	MfG
> 	bmg
> 
> -- 
> "Des is völlig wurscht, was heut beschlos- | M G
> Berberich
>  sen wird: I bin sowieso dagegn!"          |
> berberic-vmG2aq7wDA3mFSIgyKwhw7NAH6kLmebB@public.gmane.org
> (SPD-Stadtrat Kurt Schindler; Regensburg)  |
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
