From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: RE: Custom Override for DSDT?
Date: Sat, 14 Dec 2002 00:16:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213231650.GW4327@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A59A@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A59A-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Matthew Tippett' <matthew-+XluyfkzffvQT0dZR+AlfA@public.gmane.org>, 'Craig Whitmore' <lennon-q3Ck4f9/EBK9koe0gwxAeg@public.gmane.org>, chbm-tNiY1ywYjSU@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 13, 2002 at 02:59:58PM -0800, Grover, Andrew wrote:
> > From: Matthew Tippett [mailto:matthew-+XluyfkzffvQT0dZR+AlfA@public.gmane.org] 
> > Getting back to the original question, would it make sense to 
> > support a 
> > way of overriding a dsdt to allow a broken BIOS that the manufacturer 
> > won't fix be usable?
> > 
> > This still keeps standards based ACPI compliance but with the 
> > nice twist 
> >   that we don't have to rely entirely on the manufacturer for 
> > the BIOS 
> > to work.
> 
> We have this. Old documentation of the procedure is at
> http://developer.intel.com/technology/iapc/acpi/bios_override.htm .
> 
> There is a new, easier way to do it, that various people have documented.
> (Ducrot, perhaps?) We will be updating that URL with the new method at some

http://www.poupinou.org/acpi/over.html
or
http://www.cpqlinux/acpi-howto.html

The latter should be read by almost all 'newbies' peoples that want
to override their DSDT.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
