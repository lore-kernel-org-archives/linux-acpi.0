From: Russell Coker <russell-YtRjSb8ePh30CCvOHzKKcA@public.gmane.org>
Subject: Re: Re: Re: DSDT in initrd
Date: Fri, 23 May 2003 02:07:53 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305230207.53225.russell@coker.com.au>
References: <F760B14C9561B941B89469F59BA3A84725A2B3@orsmsx401.jf.intel.com> <1053603651.2541.10.camel@dhcp22.swansea.linux.org.uk> <20030522133132.GJ346@poupinou.org>
Reply-To: Russell Coker <russell-YtRjSb8ePh30CCvOHzKKcA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030522133132.GJ346-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 22 May 2003 23:31, Ducrot Bruno wrote:
> > On a lot of non x86 platforms Lilo is considerably more featureful.
> > Initrd basically exists as a way to take an arbitary bootloader and feed
> > it stuff. In some cases the tools even nail the initrd onto the end of
> > the binary because the boot loader isnt smart enough to load.
>
> I don't understand.  On a lot of non x86 lilo do not even exist (PPC <-
> quick or yaboot, SPARC <- silo) etc.

To be more precise, LILO only exists on i386.  Large amounts of LILO code are 
x86 assembler.  Most of the code in the main /usr/bin/lilo program is 
designed to guess what the BIOS expects and put things in the right place 
(determining IBM PC BIOS codes from Linux device nodes, etc).

Of course you could probably port LILO to a non-x86 platform, but then it 
probably wouldn't be recognisable.  Half the options in /etc/lilo.conf would 
need to be changed or removed.

I'm not sure what Alan means.  But on x86 LILO has many desirable features 
that other boot loaders lack.  LILO supports serial consoles, graphical 
splash screens, and isn't really painful to install.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
