From: Alexei Gilchrist <alexei-JAjqph6Yjy/o0IyPN7li9Ydd74u8MsAO@public.gmane.org>
Subject: Re: PROBLEM: ACPI crashes (2.6.2-rc2-mm1)
Date: Thu, 29 Jan 2004 10:49:47 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040129004947.GA2723@physics.uq.edu.au>
References: <m3n087khfl.fsf@reason.gnu-hamburg> <401811E8.8060003@pca.it> <20040128200719.M75620@morningdave.org> <40181916.2050408@xms.se> <40182D90.8090102@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40182D90.8090102-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On my Panasonic W2 (also with 855GM) swsusp2 will hang on resume when
running 2.6.1 (from X). Running 2.4.23 will work happily --- from console,
from X with vesa driver and X with i810 driver.

I've had mixed results with USB on resume, which can usually be fixed by
unloading the modules and reloading them. I'm not using DRI.

cheers,

Alexei


On Wed, Jan 28, 2004 at 10:45:52PM +0100, Luca Capello did merrily tap:
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



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
