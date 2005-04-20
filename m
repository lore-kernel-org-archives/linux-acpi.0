From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: _CST implementation
Date: Wed, 20 Apr 2005 11:45:56 +0200
Message-ID: <20050420094556.GN2298@poupinou.org>
References: <1113598244.8367.30.camel@scotchmobil> <20050418120744.GG2298@poupinou.org> <4263EDA2.4030106@suse.de> <20050419092251.GK2298@poupinou.org> <4264F251.5030705@suse.de> <20050419134518.GL2298@poupinou.org> <20050419200505.GE19499@message-id.gmane0305.slipkontur.de> <42656601.3060304@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42656601.3060304-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 19, 2005 at 04:11:45PM -0400, Rich Townsend wrote:
> Stefan Seyfried wrote:
> > On Tue, Apr 19, 2005 at 03:45:18PM +0200, Bruno Ducrot wrote:
> > 
> > 
> >>IOW, from spec we should not invalidate, but from "common practice" by
> >>bios writters, we should invalidate.
> > 
> > 
> > What about a "spec_compliant_but_beware_of_stupid_bios_writers" module
> > parameter? ;-)
> 
> I fear that would be set to nonzero on every system...
> 

That's the case already.  This is the boot parameter
acpi=strict


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
