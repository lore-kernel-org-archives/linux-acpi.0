From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] [2/2] Allow override acpi_gbl_pre_defined_names (aka change that _OS).
Date: Wed, 5 Feb 2003 20:27:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030205192720.GM1205@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84725A15A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A15A-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Dave Jones <davej-l3A5Bk7waGM@public.gmane.org>, =?iso-8859-1?Q?Zden=ECk_OGAR_Skal=E1k?= <skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 05, 2003 at 10:55:45AM -0800, Grover, Andrew wrote:
> > From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] 
> > This is the linux part.  It permit to pass a apci_os_name= boot args
> > in order to override the \_OS.
> 
> I'm still not clear on why this needs to be changeable at runtime. If we do
> decide that the BIOS writers are so Windows-centric that we need to
> masquerade as one, why wouldn't we just change the #define and recompile?
> 
> Dave, can you help me understand how a distro would find this useful, over
> just statically changing the reported _OS string?

I can not speak for Dave, but suppose that you say to an end user:
Hum, yes, your mouse do not work after S1..

Get the latest kernel of the distro via apt-get, rpm, what ever, then
edit the file /path/to/kernel/include/acpi/platform/aclinux.h

find the
#define ACPI_OS_NAME                "Linux"
line then change so that
#define ACPI_OS_NAME                "Microsoft Windows NT"

recompile, etc.

Now suppose that you said to the same end user:
Add acpi_os_name="Microsoft Windows NT" at boot time, and now
your mouse will work without any tricks after S1 and with gpm
or under X.


Now, I don't like the idea to have a 
include/acpi/platform/aclinux.h
which say that my OS is a MS one, and I guess nobody want it.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
