From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Thu, 6 Feb 2003 21:56:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030206205608.GV1205@poup.poupinou.org>
References: <20030131173904.GA3240@poup.poupinou.org> <20030205014041.GA27937@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030205014041.GA27937-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 05, 2003 at 01:40:41AM +0000, Matthew Garrett wrote:
> On Fri, Jan 31, 2003 at 06:39:04PM +0100, Ducrot Bruno wrote:
> 
> Hi Ducrot,
> 
> > This is the 'minimal' requirement.  Some devices (especially the
> > IDE part) are not well resumed.  Handle with care..
> 
> Using this patch (on top of 2.5.59 and acpi 20030123), echo 4b 
> >/proc/acpi/sleep results in the system freezing all of the processes 
> and then resetting itself without any state change. This is an IBM 
> Thinkpad 240x which claims to support S4Bios, and I have the appropriate 
> partition. Would it be worth me enabling debugging and hooking up a 
> serial console?
> 

Strange.  What say dmesg?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
