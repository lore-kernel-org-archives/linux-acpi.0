From: Michael Frank <mflt1-DTdK3Ks6N5kHTnRCetW4+N0b+6lKrnBL@public.gmane.org>
Subject: Re: DSDT in initrd
Date: Fri, 16 May 2003 14:24:12 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305161424.12274.mflt1@micrologica.com.hk>
References: <A5974D8E5F98D511BB910002A50A6647054FC400@hdsmsx103.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A5974D8E5F98D511BB910002A50A6647054FC400-MgY+aF+eRfZviC08c4yzC1DQ4js95KgL@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday 16 May 2003 09:41, Brown, Len wrote:
> > IMHO this patch is very useful because it provides the
> > equivalent of a "DSDT module" and avoids building a kernel
> > for each DSDT.
>
> This is the 1st reason I've seen for not simply using an
> ACPI_DSDT_OVERRIDE config option to pull a DSDT into the kernel
> from a well-known file name.

DSDT problems will be around for a long time as this technology makes it into the main stream, while still maturing.

For example: I found DSDT of a recent P4 mainboard has 16 compile errors. 

Realistically, one can't go really into production with it without being able to override.

>
> I figure that the set of people who go to the trouble to get a
> custom DSDT are mostly included in the set of people who config and
> build a kernel for their system.  As such, ACPI_DSDT_OVERRIDE would
> be simple and sufficient -- without requiring admins to change any
> code

A fixed override at build time was OK during the development phase.

However, this is totally impractical in a production environment. It's simply not maintainable.

A modular DSDT has further benefits:

  - Given the quality of the current DSDT 
    tools, it may encourage more  testing 
    and fixing of DSDTs

  - Distribution installers eventualy 
    could handle the selection and 
    installation of a DSDT

>
> It makes me uneasy to append the DSDT to the initrd image.  This
> encumbers the initrd booting scheme with ACPI BIOS workarounds. 
> What happens when somebody changes how initrd works?  If appending
> a DSDT image to initrd is okay, 

Touching a standard is good cause for concern, but the magnitude of 
change is relatively small and transparent to the enduser.

Emphasizing "modular", we can look at this patch as incremental progress helping ACPI into a production environment.

This patch should be selectable by a seperate config option.

> why not append other things such as
> the ACPI black-list, for the same reasons?

Deserves further consideration as port of continued evolution of the ACPI subsystem. 

>
> I think I'd be happier with the DSDT being _in_ the initrd as a
> named file/module -- just like the other boot-time modules, rather
> than being magically appended to the image.  Of course this would
> require you to run mkinitrd for each platform; unless multiple
> named tables were included in the initrd.
>

Which IMHO is better, more flexible, "standard" and should be the next step

One might consider a means of selecting DSDT's using the blacklist and put all into initrd.....


Regards
Michael

 



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
