From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: turning off individual devices
Date: Sun, 7 Mar 2004 12:14:03 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <LAW11-OE28rgnPmS5hc0002cda7@hotmail.com>
References: <20040305222117.GA20865@rap.rap.dk> <Law11-OE414phnpK9h70002b8bd@hotmail.com> <20040307090622.GA14593@rap.rap.dk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Keld_J=F8rn_Simonsen?= <keld-6PR53cSIHaE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

As I said, according to the docs "detach_state" is the state in which to put the device after you "rmmod" its driver, so I wouldn't
expect any immediate results when you put any value into it.
Also, you might want to take a look at a posting I just did to the kernel list, titled "PCI, PM, & sysfs interaction", which is the
result of playing around with "/sys/..../power/state", trying to get my NIC into D1/D2/D3. The conclusions from my experiment is
that it is rather broken.


----- Original Message ----- 
From: "Keld Jørn Simonsen" <keld-6PR53cSIHaE@public.gmane.org>
To: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: "Keld Jørn Simonsen" <keld-6PR53cSIHaE@public.gmane.org>; <acpi-devel@lists.sourceforge.net>
Sent: Sunday, March 07, 2004 4:06 AM
Subject: Re: [ACPI] turning off individual devices


On Fri, Mar 05, 2004 at 11:21:37PM -0500, Dino Klein wrote:
> check kernel/Documentation/power/devices.txt
> the value there indicates in which state to put the device after the driver detaches from it.

Yes, I did read that document before posting. That document says that:
A value of 4 indicates that the device should be shutdown, so
->shutdown() will be called for that device.

But it does not seem to have an effect.
And I do not seem to have a driver running for that device.

But does that matter whether the device is in use or not?
Or should there be an error message if the device is in use?

> ----- Original Message ----- 
> From: "Keld Jørn Simonsen" <keld-6PR53cSIHaE@public.gmane.org>
> To: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Sent: Friday, March 05, 2004 5:21 PM
> Subject: [ACPI] turning off individual devices
>
>
> > I try to turn off individual devices by saying
> >
> >    echo -n 4 >  /sys/devices/pci0000:00/0000:00:1f.6/detach_state
> >
> > But it seems that nothing happens. Am I missing something?
> > Kernel 2.6.3
> >
> > Keld



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
