From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: Re: DSDT in initrd
Date: Thu, 22 May 2003 15:31:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030522133132.GJ346@poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84725A2B3@orsmsx401.jf.intel.com> <1053603651.2541.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1053603651.2541.10.camel-2MMpYkNvuYAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, May 22, 2003 at 12:40:52PM +0100, Alan Cox wrote:
> On Iau, 2003-05-22 at 08:48, Grover, Andrew wrote:
> > can load individual modules. The limitations of lilo should not be taken
> > to be the limitations of all boot loaders. lilo is the lowest common
> > denominator loader, and while we want Linux to work with it, Linux could
> > work *better* if we took advantage of grub's additional capabilities.
> 
> On a lot of non x86 platforms Lilo is considerably more featureful.
> Initrd basically exists as a way to take an arbitary bootloader and feed
> it stuff. In some cases the tools even nail the initrd onto the end of
> the binary because the boot loader isnt smart enough to load.

I don't understand.  On a lot of non x86 lilo do not even exist (PPC <- quick
or yaboot, SPARC <- silo) etc.

> 
> > What this enables is not only an elimination of the hassle of initrd, it
> > enables previously unmodularizable things like ACPI, or PCI, or all the
> > special code needed for x86 subarchs, or whatever other code that one
> > machine needs (highmem?) but that most do not to now be modularized.
> 
> I'm not sure it does. A lot of the stuff like handling multiple system
> variants requires you are able to handle all of them until you reach a 
> point where you know the one you want. 
> 
> Modularisation is the key but I suspect we actually want to turn the
> problem inside out. If for example all the ACPI stuff was linked into an
> acpi.text and acpi.data section then we can boot, having established we
> don't need acpi we can eject acpi just like we eject __init code.
> 
> > Having the modules specified individually to the bootloader makes things
> > simpler.
> 
> Whats the difference between feedling the list to the bootloader or to
> mkinitrd ?

You can retrieve most hardware configuration (PnP, ACPI, etc) via a module
at boot loader stage, even if kernel is not launched, not after you have
access to the fs inside the initrd image.

> 
> > Having an in-kernel linker lets previously unmodularizable code be
> > modularized.
> 
> Definitely - and Rusty has done that for 2.5.x

Just a question (I have not looked).  Can you preload modules or
discharge them before booting kernel with 2.5 (as in FreeBSD) ?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
