From: "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>
Subject: RE: S3 Resume working, but IDE disk hung
Date: Wed, 09 Oct 2002 10:35:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1DD88DDBBB83D6119C8C00096BB0408FCE495C@USAMCMS5>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-return: allowed
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
Cc: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

All,

 I took Andre's advice and implemented the reset(), wait for completion,
then call piix_config_drive_xfer_rate().  This gets the disk back into a
sane state and is useable (but code isn't yet ready for primetime:).  I had
to create a new reset function in ide-iops.c that didn't set a timer,
instead I pulled logic from do_reset1() and reset_pollfunc(), resetting the
disk and just looping until reset is seen complete.  The fix Pavel put in
2.5.41, doesn't fix IDE disk after resume (at least on my system). 

 FYI - The do_reset1()/reset_pollfunc() have a bug that panics the kernel in
kernel/timer.c:112 (check for timer pending) that isn't related to
suspend/resume.  Doing a "hdparm -w /dev/hda" will cause the panic.

 The suspend/resume in the piix.c is registered in PCI device structure and
called through Device_Resume(), it would be nicer if the upper IDE layers
would coordinate these activities.  When we resume from S3, we know that all
IDE interfaces/drives need to reset and re-initialized. The IDE layer could
call init functions again (of course want to avoid re-registering and a lot
of initialization code is prefixed with __init) or reset devices.   Any
thoughts on this approach, where to start, am I way off, etc.?  

 Also, in trying to get the serial port working after resume, I noticed that
routines registered with pm_register() never get called on an S3 transition
(only on S4 suspend to disk).  I added a call to pm_send_all(SUSPEND) and
pm_send_all(RESUME) in drivers/acpi/sleep.c: acpi_suspend().  This caused
serial port suspend/resume functions to now be called (of course serial port
didn't quite come back, it seems to receive characters but not transmit
any?) and my IDE fix gets run twice.  Are these two suspends (S3 & S4)
suppose to play better together?  What is the relationship with kernel/pm.c
stuff and acpi/sleep.c stuff?

 I apologize if any of these questions have already been answered or debated
before.

 Thanks for help,

  Mike


> -----Original Message-----
> From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org]
> Sent: Tuesday, October 08, 2002 4:21 PM
> To: Andre Hedrick
> Cc: Ducrot Bruno; Alan Cox; Faraoni, Michael;
> acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] S3 Resume working, but IDE disk hung
> 
> 
> Hi!
> 
> > > [Note, you should look at the patch "to prevent data 
> corruption". It
> > > could do the trick. At least it should be good as a base.
> > > 
> > > > Prior to suspend one needs to :
> > > > 
> > > > 	block all new coming requests.
> > > > 	flush cache and wait for return.
> > > > 	disable DMA, and switch to PIO 0.
> > > 
> > > Why would you want to switch off DMA and go PIO 0?
> > 
> > Because it is a known state when we drop out of the driver.
> > 99% of the failures of ACPI (please read the fine print, 
> where it requires
> > discrete access to "task file registers") is not knowing 
> where or what
> > stated the device and driver is set in.
> > 
> > The reality is it does not matter if it is in PIO 0 to the 
> hardware, but
> > setting the values in the kernel so it knows what to do is critical.
> > 
> > > As long as DMA is not happening (that is not disabled, we 
> just don't
> > > ask drive to do it), you should be fine.
> >                        ^^^^^^^^^^^^^^^^^^
> > 
> > Should does not cut it, period.
> > Either you are or are not correct.
> 
> Which spec does specify it needs to be in PIO0? I don't want to read
> between the lines.
> 
> Actually, working around broken ACPI is probably good idea. And as
> Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> shown, such broken ACPI exists.
> 
> > > > Resume requires calling :
> > > > 
> > > > 	"do_reset()"
> > > > 	for (;;)
> > > > 		if ((check_power()) == active)
> > > > 			break;
> > > > 	"piix_config_drive_xfer_rate()" 
> > > > 	unblock request pathway.
> > > 
> > > You don't need to block/unblock request pathways. kernel/suspend.c
> > > takes care of that.
> > 
> > Really, try sending a command to a drive when it is not 
> ready.  Try send
> > it to after a sleep, and watch it eat the command and hang the bus.
> 
> You can't send a command to the drive when not ready, because there's
> noone there to generate request. If there is one, you have bigger
> problems than that.
> 
> > It really seems like you can not or will not listen to 
> real-documented
> > logical concerns.  So please do as you wish and push it 
> through, it does
> > not bother me.  It will give me another chance to blast Linus and
> > deflect
> 
> Okay. What's in there in 2.5.41 is fine with me (at least it does not
> eat disks any more). Doing while check_power() and going PIO 0 seems
> like good idea, and if someone wishes to add it, good luck for
> him. blocking/unblocking request pathways is bad idea and is not
> needed.
> 								Pavel
> -- 
> When do you have heart between your knees?
> 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
