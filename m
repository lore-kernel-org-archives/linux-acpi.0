From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI-Errors with battery, ac_adapter, thermal
Date: Fri, 24 Jan 2003 21:03:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030124200355.GC18109@poup.poupinou.org>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19BA55@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19BA55-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Ducrot Bruno' <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, 'Faye Pearson' <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>, Stefan Behnel <behnel-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 24, 2003 at 07:07:36AM -0800, Moore, Robert wrote:
> Yes, I agree that it's a bug in the original ASL.
> 

Well, but actually I would prefer to know what should be Local0 in that
context.  I think that the Windows one will left Local0 as '0' because
(hopefully..) it will put the equivalent of NULL in Local0 (considered
as if it shoud be a ref) but, who knows.  The only way to go for sure
is to dig harder in the ASL, though.

It's hard sometimes to try to guess what was the intention of
the BIOS writer :(

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
