From: Dave Jones <davej-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Intel ACPI
Date: Wed, 5 Feb 2003 13:30:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030205133049.A18324@suse.de>
References: <4.3.2.7.2.20030204000748.00b62270@mail.dns-host.com> <20030204094540.GE1205@poup.poupinou.org> <20030204132251.E16744@suse.de> <20030204154359.GH1205@poup.poupinou.org> <20030204164641.A31886@suse.de> <20030204155548.GI1205@poup.poupinou.org> <3E40AF32.AA177847@monetplus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E40AF32.AA177847-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>; from skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org on Wed, Feb 05, 2003 at 07:29:06AM +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?Zden=ECk_OGAR_Skal=E1k?= <skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 05, 2003 at 07:29:06AM +0100, Zdenìk OGAR Skalák wrote:
 > 	So could we add kernel boot argument to allow changig/overriding the \_OS
 > string? Eg. acpi_os="Microsoft Windows NT" to allow us to play with it without
 > rekompiling the kernel ?

A bootarg does seem to be the most sensible way to do it. You need
to set it early enough so that you catch everything. Doing it later
through a sysctl or the like would be too late, and doing it statically
at compile time would make it useless for vendor kernels.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
