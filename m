From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: 23 Feb 2004 01:31:47 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077517907.12673.43.camel@dhcppc4>
References: <4038F499.2060302@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4038F499.2060302-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: nick <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-02-22 at 13:27, nick wrote:
> I am new to ACPI but I have searched the archives, looked at the MAN 
> pages used Google to the best of
> my abilities and I still have some questions about ACPI. My basic goal 
> is to be able
> to suspend my desktop machine to S3 when not in use. I need to use the
> machine several times throughout the day, and feel it is a waste to leave
> it on continuously. The system spec are: Intel D875PBZ, Intel P4 3GHZ,
> Radeonm 9700 pro, Sounblaster Live, Debian unstable with 2.4.23 and
> 2.6.2 kernels available, both with ACPI compiled as modules. Pressing
> the power button once gracefully shuts down the machine running either 
> kernel.
> 
> After reading the documentation, I am still not sure how to try to
> suspend to S3. Is there anyone with this motherboard succesfully using
> S3 suspend? Is it reliable and stable, suspend after suspend.
> Is S3 suspend with Linux on the desktop the Holy Grail of ACPI? The
> machines suspends to S3 in Windows 2000 Pro, also shuts all the fans
> down too, totally silent.
> 
> Any advice would be appreciated.
> Can anyone recommend any Pentium 3/4 desktop motherboard that will S3 
> reliably in Linux?
> 
> If this is not possible yet, are there any other Linux hardware problems 
> where S3 works reliably?

I've got a laptop running Fedora Core 2 out of the box, and all I do is

# echo 3 >/proc/acpi/sleep
and I use the power button to wake it up.

I've also got a D875PBZ, however

[root-BJIgRQarj28@public.gmane.org /]# echo -n 3 >/proc/acpi/sleep
Stopping tasks: ==============================
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, katad-1 not stopped
 done
[root-BJIgRQarj28@public.gmane.org /]#

which I guess is due to its SATA boot drive.
Do you have a regular PATA drive?

cheers,
-Len




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
