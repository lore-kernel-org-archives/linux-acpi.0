From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: DPMS with ACPI
Date: Mon, 9 Dec 2002 11:46:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021209104627.GA26375@poup.poupinou.org>
References: <20021207171140.363b2276.gigerstyle@gmx.ch> <20021207165727.17f6222a.taw27@cam.ac.uk> <20021207182449.602ce242.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021207182449.602ce242.gigerstyle-OI3hZJvNYWs@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marc Giger <gigerstyle-OI3hZJvNYWs@public.gmane.org>
Cc: Thomas White <taw27-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 07, 2002 at 06:24:49PM +0100, Marc Giger wrote:
> Hi Thomas,
> 

[...]

> On my Laptop not:-( 
> 
> It's also a Vaio GR114EK. This Vaio is a difficult case:-))
> 
> What i get with "xset dpms force standby" is:
> 
> X Error of failed request: BadMatch (invalid parameter attributes)
>   Major opcode of failed request: 140 (DPMS)
>   Minor opcode of failed request: 6 (DPMSForceLevel)
>   Serial number of failed request: 10
>   Current serial number in output stream: 12
> 
> I have activated the DPMS in XF86Config with 'Option "DPMS"'
> What I get is:
> 
> ....
> Option "DPMS" is not used
> <snip>
> Open APM failed (/dev/apm_bios) (No such device)
> ...

This two errors that are not related.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
