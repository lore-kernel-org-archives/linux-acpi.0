From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: ACPI + Laptop Power Management
Date: Fri, 28 Nov 2003 20:09:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031128180909.GA27807@luna.mooo.com>
References: <C386328088ED7F4E9F81AFBABDDF60DA0338640F@wdmyexch02.my.asia.wdc.com> <20031128154714.GP7374@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031128154714.GP7374-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 28, 2003 at 04:47:14PM +0100, Ducrot Bruno wrote:
> On Fri, Nov 28, 2003 at 11:21:19AM +0800, Ow Mun Heng wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Micha Feigin [mailto:michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org]
> > > Sent: Friday, November 21, 2003 7:13 PM
> > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > Subject: Re: [ACPI] ACPI + Laptop Power Management
> > > 
> > > 
> > > On Fri, Nov 21, 2003 at 11:12:32AM +0100, Ducrot Bruno wrote:
>                                               ^^^^^^^^^^^^
> 
> I *never* wrote the following (but there are good stuff
> inside).
> 
> > > like said here, laptopmode is what you want since it holds back dirty
> > > buffer flushes which is what you are experiencing. It will fire up the
> > > disk on reads though. I attached a script that you can use to enter
> > > laptopmode (was actually distributed with laptopmode as far as I could
> > > tell when googling for the original patch). I call it in responce to
> > > ac events from acpid to get it running when the power is disconnected.
> > > Will have to make sure that you get those event though since I had to
> > > twik my dsdt for that.
> > > You can also look at cpufreq of acpi cpu throttling to 
> > > throttle down you
> > > cpu when on battery to conserve power (assuming you cpu 
> > > supports that).
> > 
> > I took a look at laptop mode. However, as the author said "it adds a
> > non-significant" amount of battery time.
> 
> Where have you read that?
> Have you looked at linux/Documentation/laptop-mode.txt?
> 
> 
> > The thing here is, even though it's flushing the buffers when there are
> > others to flush, it makes not difference if the drive is still spinning and
> > not in standby-mode! I can't figure out what is making the HD _not_ spin
> > down.
> 
> man hdparm, hdparm -S something.
> 
> > BTW, Laptop_mode is merged into the 2.4.23-rc5 kernel (based on the
> > changelogs)
> 
> As already said.
> 
> > With regard to ACPId events, can you tell me how yo get it to work? I'm
> > having problems getting it running. It gets lodaded up during init, and it's
> > running as root, but after logging in (GDM desktop), the events won't fire
> > until I kill the acpid process and re-run it again. (once I logged in)
> > I can't figure out how to get it to work. I read in one page where the
> > auther said to put xhost +local somewhere at the end of /etc/X11/xinitrc.
> > That didn't work either.
> 
> I don't know.  All my scripts for power managements via acpid certainly
> do not use X.  I am wondering what is inside yours, but if they come
> as default with a distribution, it is probably better to use another
> distribution.
> 
> I doubt also the author of laptop-mode have done that.  Again, read
> the documentation which come with laptop-mode.
> 
> > > I patched reiserfs to change the journal commit time 
> > > according to the entry in
> > > bdflush so that I can get the regular 30 sec journal flush 
> > > time when on
> > > ac and 10 minutes when of battery.
> > > I could try making such a patch for ext3 if you want.
> > 
> > You mean that has to be patched at the Kernel Code Level?? Ah.. Dang!
> > 
> 
> If you read the laptop-mode documentation, you will know that reiserfs
> have to be modified, but not ext3.  BTW, I don't use reiserfs.
> 

I guess that is meant for me. I read that but at the time I looked at
the diff and saw that the change was done in the jfs directory, so only
when I later looked at the code to see where ext3 should be patched I
saw that that was the change for ext3.
I wrote a reply saying that, but I had some trouble with my email so I'm
not sure if it got through.

> -- 
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
