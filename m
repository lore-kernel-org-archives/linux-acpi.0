From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: _PDC method in DSDT
Date: Mon, 23 Jun 2003 13:51:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030623115153.GW19556@poupinou.org>
References: <1056329130.10322.36.camel@aldebaran.caltech.edu> <20030623100744.GU19556@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030623100744.GU19556-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 23, 2003 at 12:07:44PM +0200, Ducrot Bruno wrote:
> On Sun, Jun 22, 2003 at 05:45:31PM -0700, David Moore wrote:
> > Hi,
> > 
> > Does anyone know the purpose or specification of the _PDC method of the
> > DSDT?  It's a reserved method that exists on my laptop (a Dell Latitude
> > D600) but does not seem to be documented in the ACPI specification on
> > the web.
> > 
> > The reason I ask is that I'm interested in porting the cpufreq driver
> > for Enhanced Speedstep to ACPI.  Right now, the cpufreq driver has the
> > tables of proper MSR register values encoded into the source, but a more
> > elegant solution would be to get this information from ACPI.  In my DSDT
> > source I notice that when the _PDC method is called properly, the _PCT
> > method will return FixedHardware addresses for the Enhanced Speedstep
> > MSRs instead of its normal SystemIO ports.  To get this to work on more
> > than just my system, I should probably use the proper specification for
> > calling _PDC rather than just making it work.
> > 
> > Anyone have any suggestions?
> > 
> 
> 
> Too late...  A CPUFreq driver is already writen and is in the CPUFreq cvs.
> 

Sorry, I had not read enough your mail.  The reason why the speedstep-centrino
driver do not use ACPI is that we do want to support even people which do
not want ACPI.  Therefore, this is more a design question but for
CPUFreq, not ACPI.

In my humble opinion,  _PDC method is stupid, since anyway this
imply a legacy CPU driver to be written in all case.  And worst,
some other CPU like the Athlon XP will even not have
any real benefice from it.  Why bother for something that have
been written specifically for Intel processor and seems more
actually a bad design at first?

If you want to discuss more on this topic, you should post to the
cpufreq mailing-list, not to the ACPI mailing-list, anyway.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
