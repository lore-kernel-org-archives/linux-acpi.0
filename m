From: Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
Subject: Re: S3 Resume working, but IDE disk hung
Date: Fri, 4 Oct 2002 23:57:13 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.10.10210042302000.10557-100000@master.linux-ide.org>
References: <1033746424.32384.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1033746424.32384.41.camel-MMxVpc8zpTQVh3rx8e9g/fyykp6/JSeS3vcXtXqGYxw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Faraoni, Michael" <Michael.Faraoni-YwRvm6FT6jBDPfheJLI6IQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Prior to suspend one needs to :

	block all new coming requests.
	flush cache and wait for return.
	disable DMA, and switch to PIO 0.
	then S3 and S4 should/will be stable.

Resume requires calling :

	"do_reset()"
	for (;;)
		if ((check_power()) == active)
			break;
	"piix_config_drive_xfer_rate()" 
	unblock request pathway.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On 4 Oct 2002, Alan Cox wrote:

> On Fri, 2002-10-04 at 16:02, Faraoni, Michael wrote:
> >  I have looked into the present IDE suspend/resume, but they don't appear to
> > be called in S3 mode (my printk in ide-disk.c do_idedisk_resume() didn't
> > happen).  I kludged the piix.c file, adding a suspend and resume routine to
> > PCI device structure (which gets called).  In the resume I forced a call to
> > piix_config_drive_xfer_rate(), which does get the disk back to being useable
> > again, but I know this is in NO way the correct method :)
> 
> When you come back you want to reconfigure the controller and drive,
> then possibly need to wake the drive. The reconfiguration may well need
> more than a retune - you might for example have lost the multimode
> settings, the host protected area etc. I would argue that you pretty
> much need to reinitialize the controller - you don't know if a drive
> changed, the cables changed etc from S4 and S3 needs most of the same
> support anyway.
> 
> You are certainly on the right track and its a sane starting point.
> 
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
