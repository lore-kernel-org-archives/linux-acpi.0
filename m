From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Desktop and S3 suspend the Holy Grail of ACPI?
Date: Sun, 22 Feb 2004 21:25:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040222202519.GB2869@poupinou.org>
References: <4038F499.2060302@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Feb 22, 2004 at 01:27:37PM -0500, nick wrote:
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
> 

There is at least one problem for which I don't think that you will have
S3 working even in the near future.
You do have a radeon 9700 and due to lack of supports by ATI those days,
I don't see how a developper can include power management codes in any
drivers other than by a cycle of guess, then try and guess again what
happens on errors.
Note that S3 may work though if you do not have AGPGART compiled,
and you do not use any kind of binary-only drm drivers from ATI.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
