From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: Acpi-devel digest, Vol 1 #766 - 4 msgs
Date: Tue, 21 Jan 2003 11:03:01 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030121100301.GA14593@poup.poupinou.org>
References: <E18aorV-0004ws-00@sc8-sf-list2.sourceforge.net> <000601c2c130$4a7d1ea0$64f1dc0c@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000601c2c130$4a7d1ea0$64f1dc0c-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James Shatto <shadow.seven-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 21, 2003 at 04:34:26AM -0500, James Shatto wrote:
> Pardon my newness to ACPI.  That being said, I have an ACPI problem.
> However inconsistent it may be.  The problem being sometimes it works, and
> when it does it keeps the computer cooler than APM, maybe even cooler than
> WinME.  But when it doesn't my laptop gets really hot and shuts itself down.
> 
> Is there anyway to fix this?
> Should I always use APM instead of ACPI?
> Should I use APM and ACPI?
> (The problem here is that SonyPI conflicts with APM)
> 
> Laptop ='s Sony Vaio - PCG-FX215 - PIII 800MHz Duron
> VIA Tech VT82C686 Power Management Controller
> 

There is a known problem with ACPI and sonypi.  Be sure
to have the latest patch from ACPI and also check if
sonypi call the provided ec_get() ec_set() functions from acpi
instead of their own.  I know that this is already the case
for 2.5 series, but I have not checked that for 2.4 series.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
