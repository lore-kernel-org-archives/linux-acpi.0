From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Wed, 28 Jan 2004 18:48:57 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075333736.5567.12.camel@localhost>
References: <m3n087khfl.fsf@reason.gnu-hamburg> <401811E8.8060003@pca.it>
	 <20040128200719.M75620@morningdave.org> <40181916.2050408@xms.se>
	 <40182D90.8090102@pca.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40182D90.8090102-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

  Just wanted to add my experience. I was able to suspend to disk and
resume just fine from a console with the following configuration on the
Gateway 200X.

kernel 2.6.1
agpgart module loaded
intel_agp module loaded
i830 module loaded
swsusp compiled into the kernel
ACPI sleep states compiled into the kernel
suspend with 'echo 4 > /proc/acpi/sleep'

   When I tried this after starting X with startx, I got the reboot loop
described by others. I figured I'd give it a shot, since the AGP modules
didn't interfere with the console suspend/resume. Ah well. 

   Interestingly, starting X and then dropping back into a console
caused problems, too. I didn't get stuck in a reboot loop, but the
resume just hung. It did get past the 'Waiting for DMA to settle down'
message, though. I can't remember now exactly what it said, but it
seemed to be mostly done. I had to do a hard reboot to get it back, and
then I had to do the 'noresume; mkswap; swapon' routine.

   I haven't tried unaccelerated X, since the AGP modules seem to be
loaded regardless of what I do (remove the agpgart alias in
/etc/modules.conf, remove X from default runlevel, etc) and I cannot
unload them. I guess I should try compiling a kernel without AGP support
at all next.

   Thanks,
    Greg
  

On Wed, 2004-01-28 at 16:45, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> on 01/28/04 21:18, Jonas Petersson wrote:
> > For the record: Several of us over on the swsusp list appear to have
> > rouchly the same problem: With some effort and fiddling (as described in
> > the previous mail), swsusp2 works for console and even from
> > unaccelerated X, but whenever DRI ang AGP is enabled it resume will
> > crash. [...]
> just for the record, in my case, 'swsusp' (normal, not the 'swsusp2' by
> Nigel Cunningham) works *perfectly* without DRI and AGP. 'Perfectly'
> means that I can suspend from X (obviously, unaccelerated) and
> successfully resume on X with the USB and ALSA (0.9.7) modules loaded
> (but as I don't have any USB devices here, I can't tell if USB working
> let you suspend/resume). This is a starting point, I hope, even for the
> 'swsusp' mode.
> 
> I never tried 'swsusp2', I could give it a try if necessary. The same
> for 'pmdisk'.
> 
> > [...] Some of us think this is related to the agpgart rewrite for
> > 2.6.x, but our patching so far have not made any difference. There seem
> > to be resume code in the intel-agp plug which we have tried to duplicate
> > in sis-agp, but it appears not to be called during resume...
> Well, I could try on 2.4.23 to find out if the problem is 2.6 or not.
> Anyway, what is strange is that the problem is on an Intel graphics
> chipset, so it the 'intel-agp' has some resume code, it /should/ work.
> And this isn't the case :-(
> 
> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQFAGC2PVAp7Xm10JmkRAtzkAJ0av0/zp68P5bNNI/G/WasPpVMoRgCfYR8z
> 2dan6DRA9q1gqVAbRs+VyGE=
> =R2Yz
> -----END PGP SIGNATURE-----
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
