From: Edmund Rhudy <nrhudy-plZrL8KR64B+CIkdHa1UOg@public.gmane.org>
Subject: Re: Changing temperature trip points
Date: 02 Nov 2002 20:59:14 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036288754.2971.1.camel@localhost.localdomain>
References: <E187ipj-0001ss-00@usw-sf-list2.sourceforge.net>
	<000001c28231$b7cae110$c200a8c0@pikachu>  <20021102171756.GD1983@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021102171756.GD1983-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I did in fact try that, and while it lets me change the values, they
don't actually seem to affect the kernel's idea of when the fan should
come on, if at all.  I set the active trip point to 45 C and the passive
to 50 C, then ran a compile to see if the fan triggered.  While the
temperature got above 50 C, the fan never came on.  In fact, I don't
know if the fan would come on even if the originally-specified trip
points were reached.  Either way, this isn't exactly the most comforting
situation to observe.

On Sat, 2002-11-02 at 12:17, Pavel Machek wrote:
> Hi!
> 
> > On my laptop, a Gateway Solo 1400 with one of those super-integrated VIA
> > Apollo Pro133A chipsets that has basically every system function
> > integrated into it (video, sound, modem, networking, and so forth), I
> > note that the temperature trip points are excruciatingly high; so high,
> > in fact, that the processor (a Celeron 900) would be close to thermal
> > death by the time the fan would purportedly turn itself on.
> 
> I have similar problem here. HP Omnibook turns itself off long before
> passive trip point is reached.
> 
> Try echo "1:2:3:4:5" > /proc/acpi/thermal_zone/THRM/trip_points. Should work in 2.5.44; dunno
> if 2.4. backport supports it.
> 								Pavel 
> -- 
> When do you have heart between your knees?
> 





-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
