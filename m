From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Dell D600: teaching radeonfb how to wake up...
Date: Fri, 21 Nov 2003 11:24:32 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1069374272.723.44.camel@gaston>
References: <20031119180119.GB22307@tate.loria.fr>
	 <20031120111315.GB432@openzaurus.ucw.cz> <1069370504.705.32.camel@gaston>
	 <20031120234708.GA431@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031120234708.GA431-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Fri, 2003-11-21 at 10:47, Pavel Machek wrote:
> Hi!
> 
> > > If I were you, I'd create fix_ati.o module which would
> > > "do the stuff", then insert it over network. That should
> > > make debugging easier...
> > 
> > Nah, we really have to re-POST the chip. I don't know how
> > we are supposed to do that though. Either we'll have to have
> > the full POST code for a bunch of ATI chips around, which doesn't
> > seem reasonable and I don't think windows drivers do that, or
> 
> Well, if he wants to do the work for his concrete ATI chip, its fine
> with me, and I'd like to see the results.
> 
> Having fix_ati.o module is certainly easier than playing with driver
> model for testing...

My point is that he can probably NOT do the work, POSTing such a
chip is hell. I'm trying to figure out how we are supposed to do,
that is how ATI does with their own windows drivers ...

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
