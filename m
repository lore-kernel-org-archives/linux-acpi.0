From: ben lamothe <blamothe-DPNOqEs/LNQ@public.gmane.org>
Subject: Re: Thinkpad T40 Fan
Date: Thu, 5 Feb 2004 23:17:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205231732.316d7819.blamothe@mit.edu>
References: <C386328088ED7F4E9F81AFBABDDF60DA03F9E35B@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA03F9E35B-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, blamothe-DPNOqEs/LNQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Do you, or anyone else for that matter, know of any third party utils
for linux that work with the thinkpad t40.  I ran across fantulence, but
lm_sensors was a dependency, and I couldn't install it because it was
incompatable, and damaging, to thinkpad hardware.

On Fri, 6 Feb 2004 11:16:09 +0800
"Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org> wrote:

> 
> 
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Hmm, how can Windows keep the fan off but Linux can't?
> > 
> > As there is no ACPI fan device, there must be a different method to
> > control the fan on this box.
> > 
> > 1. It may be some i2c device that Windows knows about but Linux does
> > not?
> >    Maybe IBM ships some platform specific software with windows?
> >    Would be interesting to know if a from-scratch install of the
> >    generic non-IBM windows was still able to keep the fan off.
> > 
> > 2. It may be some BIOS code using SMM that Linux somehow breaks?
> > 
> > 3. It may be done entirely in hardware without the knowledge 
> > of the OS?
> > 
> > I'm hopeful that it is #3, and that Windows is simply doing better
> > passive cooling than Linux -- and perhaps we can perhaps improve our
> > passive cooling...
> > 
> > Can you run some experiments?  Maybe you can monitor the 
> > temperature in
> > windows to see if it really is cooler.  Perhaps you can 
> > experiment with
> > the power management policy settings such that it is in 
> > high-power mode
> > instead of maximum battery mode and observe the temperature rises,
> > and at what temperature the fan starts running?
> 
> 
> Hi,
> 
> 	Mine's a D600 which DSDT also does not have fan control.
> 	(currently 
> using i8kfanutil to control it) Under windows it works fine. The fan 
> can/will come on/off whenever it gets hot (I didn't do the experiments
> casuse I use Linux 95% of the time) The fan _can_ be controlled using
> a 3rd party util called FanGui if IIRC. (sort of like i8kfan) but it
> works fine generally on it's own without it. 
> 
> I was under the impression that it was the BIOS that does this.
> 
> 




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
