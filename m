From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add CONFIG_ACPI_RELAXED_AML option
Date: Fri, 13 Dec 2002 19:15:44 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213181544.GM4327@poup.poupinou.org>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B9AB@orsmsx107.jf.intel.com> <20021213171815.GS5382@whisky.intra.cprm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021213171815.GS5382-V9yvzcrGID8XxY44YfPCZCanxOoIfzq+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carlos Morgado <chbm-tNiY1ywYjSU@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 13, 2002 at 05:18:15PM +0000, Carlos Morgado wrote:
> 
> On 2002.12.13 16:22:43 +0000 "Moore, Robert" wrote:
> 
> >
> >What is really being proposed here is for Linux ACPI to be bug-for-bug
> >compatible with Microsoft.  This is impossible to do deterministically
> >because the MS interpreter is closed source.  The only standard that we 
> >have
> >that we can code to is the ACPI specification, and this has to be the last
> >word on the matter.
> >
> 
> not to mention windows tends to ignore builtin dsdts afaik and use the ones
> distributed in windows drivers. 

I suppose you think perticuliary to their ACPI EC smbus driver?
Well, I don't think that they use a perticular custom dsdt for that.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
