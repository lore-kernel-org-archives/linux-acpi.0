From: Dave Bauer <dave-eQMij45H2SHXYFsarriMmxagbA6BzR3y@public.gmane.org>
Subject: Re: ACPI stops working after memory upgrade vpr Matrix 175b4
Date: Thu, 5 Feb 2004 15:41:57 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040205204157.GC14799@thedesignexperience.org>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8ABD@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8ABD-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sure! I got it 99% working, but I am getting an AML_UNINITIALIZED_LOCAL
error message, which is pretty annoying because I can't see why its
throwing that error.

Trying with an unmodified DSDT doesn't really show much because it has
several bugs that cause the ACPI features to not work at all. I can
capture the two different streams of error messages.

Dave

On Thu, Feb 05, 2004 at 03:45:00PM -0500, Brown, Len wrote:
> Dave,
> Can you capture the e820 messages from the beginning of dmesg for the
> success and failure case so we what the BIOS says about your RAM?  Also,
> it would be good to try w/o the custom DSDT.
> 
> Thanks,
> -Len
> 
> Ps. Contrary to popular perception, e820 is defined in the ACPI spec.
> 
> > -----Original Message-----
> > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of 
> > Yu, Luming
> > Sent: Tuesday, February 03, 2004 2:07 AM
> > To: Dave Bauer; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > Subject: RE: [ACPI] ACPI stops working after memory upgrade 
> > vpr Matrix 175b4
> > 
> > 
> > > methods:....exregion-0164 [25] ex_system_memory_space: 
> > Could not map 
> > > memory at 000000000FF7FDBD, size 190
> > 
> > Maybe the root of this error is that __ioremap don't allow anybody to
> > remap
> > normal RAM. Could you verify it by checking it in 
> > arch/i386/mm/ioremap.c
> > 
> > 
> > 
> > -------------------------------------------------------
> > The SF.Net email is sponsored by EclipseCon 2004
> > Premiere Conference on Open Tools Development and Integration
> > See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> > http://www.eclipsecon.org/osdn
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > 
> 

-- 
Dave Bauer
dave-eQMij45H2SHXYFsarriMmxagbA6BzR3y@public.gmane.org
http://www.thedesignexperience.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
