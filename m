From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Thu, 8 Aug 2002 01:05:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807230502.GA3563@dutidad.twi.tudelft.nl>
References: <20020807224648.5744.qmail@scrye.com> <200208072257.SAA04328@magic-pi-ball.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200208072257.SAA04328-UAlz0gpoyMvRrlGjHHsfAOmCSIfjHtlf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sourav K Mandal <smandal-DPNOqEs/LNQ@public.gmane.org>
Cc: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 07, 2002 at 06:57:25PM -0400, Sourav K Mandal wrote:
> > The Fn f7 (dim) and Fn-f8 (brighten) and Fn-F4 (monitor) all work fine
> > when I first boot up. They also work fine if I start X with no DRM. If
> > I start X with drm, then they stop working and won't work again until
> > I reboot. 
> 
> Exactly what I'm getting, but with stock DRI modules.

Just for clarity, on my laptop (which is not a Compaq, but a no-namer with
Radeon Mobility 7500 64MB) the bright/dim keys always work, DRI or no DRI.

> > Any ideas? Could be a XFree86 version problem? 
> 
> Unforunately, not really.  :-(
> 
> My (layman's) guess is that it has something to do with the GPU's
> power state.  The BIOS won't shut down the LCD until it's
> satisfied with the Radeon's power state; once DRM is used
>  the Radeon cannot enter an acceptable power state.

If you experience this with stock XFree86 DRI as well, I would post a report
on xpert-72qDnkntNoRAfugRpC6u6w@public.gmane.org as well.  One of the ATI engineers is spending a lot of
time with these drivers and might have something to add to the equation.

> This is the inverse of the DRI-on-resume problem, that once
> the Radeon is shutdown w/o reset, the DRM "parts" don't 
> wake up properoly.

The DRM wasn't designed for stopping/starting in mid-stride, which is why
we've made it so that it completely initialises/de-initialises during
VT-switch.  If certain remaining technical problems can be sorted out, this
might even make XFree86 4.3.0, at least until a more generic solution can be
implemented.

Good luck,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
