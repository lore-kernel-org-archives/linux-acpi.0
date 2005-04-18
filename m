From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: _CST implementation
Date: Mon, 18 Apr 2005 16:21:53 +0200
Message-ID: <20050418142153.GI2298@poupinou.org>
References: <1113598244.8367.30.camel@scotchmobil> <20050418120744.GG2298@poupinou.org> <1113827030.8500.17.camel@scotchmobil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1113827030.8500.17.camel@scotchmobil>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 18, 2005 at 02:23:50PM +0200, Janosch Machowinski wrote:
> On Mon, 2005-04-18 at 14:07 +0200, Bruno Ducrot wrote:
> > On Fri, Apr 15, 2005 at 10:50:44PM +0200, Janosch Machowinski wrote:
> > > Hey, 
> > > im new to ACPI, so please be patient with my stupid questions ;-)
> > > I spend a little time in debugging my kernel ACPI and reading the 3.0
> > > specs... Now I am wondering about some pieces of the implementation. 
> > > First of all in processor_idle.c in the funktion
> > > acpi_processor_get_power_info_cst there is a test if the power.count is
> > > less than 2. Why do you test on 2 and not on 1 ? As far 
> > > as I can see 1 would be an valid value. 
> > 
> > No.  It cant be a valid value.  Consider this case:
> > 
> > Name (_CST, Package{} {
> > 		1,
> > 		Package{} {ResourceTemplate{} {Register(SystemIO, 8, 0, 0xXXXX), 2, 40, 750}
> > })
> > 
> > 
> > There are *2* elements in the package, an integer (whose value is 1) and
> > a package defining a C2 state.
> 
> I must disagree, power.count is not a variable to test, how many
> elements are in the _CST object (that would be count), pr->power.count
> is a counter for the number ob C-States that were extracted from the
> _CST Object, therefor one C-State is a C-State and should be valid. 
>   Janosch

I think I misread what you wrote.  I was thinking you were refering to
cst->package.count

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
