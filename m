From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI/ECDT on gateway 200x notebook
Date: Wed, 7 Jan 2004 13:40:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040107124047.GO14031@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401720C89@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C89-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 07, 2004 at 07:57:54PM +0800, Yu, Luming wrote:
> >The EC is a child of other devices and you
> >have to be sure that those devices are initialized before EC (even
> >though that is done by BIOS at POST already, due to legacy access
> >in some laptops).
> 
> One point is that my patch don't want to fully initialize EC devices.
> It just want to get EC resource to init EC addresspace handler ,
> Although the patch looks ugly.
> 
> The motivation is just to have EC address space 
> handler ready for devices that get initialized before EC devices on
> laptop without ECDT.   If this attempt is failed due to what you
> said,  then ECDT is necessary.
> 
> At least, it seems to work for gateway laptop. Of cause, it need to be
> refined.

Oh, I'm not against this approach, but I wanted to point you some
possible issues.  I see 3 ways for now to go:

1- your approach,
2- make a kind of setup option, like the patch I send some time ago, in
   order to fake an ECDT, but simplified (the IO ports should be
   the only options).  But that require another boot option.
3- an error runtime handler, which initialize the address space handler for
   the EC if not already done, and then retry.

I don't know what is best.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
