From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: system crashes after cat /proc/acpi/battery/BAT0/state
Date: Tue, 3 Feb 2004 11:36:14 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040203103613.GA9425@message-id.gmane0305.slipkontur.de>
References: <3ACA40606221794F80A5670F0AF15F8401CBB672@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB672-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 03, 2004 at 04:31:36PM +0800, Yu, Luming wrote:
> > excuse me, but I forgot to tell, that I'm using the ACPI DSDT initrd 
> > patch and a special DSDT-file for Compaq Evo N800v (while I have an
> > Compaq Evo N800c)
> 
> My question is whether your fixs to DSDT is correct or necessary? 
> We need to sort out real ACPI interpreter bug !

i would blame it on the wrong DSDT. I had similar problems (random crashes on
pressing some of the "Hotkeys" for example) on a ASUS L2400D with the DSDT
provided on acpi.sourceforge.net. I noticed that i had an older BIOS, so i
upgraded the BIOS to the latest version (the same as mentioned on the DSDT
page), but still got random crashes although the patched DSDT had only minimal
differences to the BIOS built-in dsdt. So now i use the built in, don't
have power management anymore but the machine runs stable again.

I have posted a comment on the dsdt page to save others from going through
the same trouble that i went throgh :-)

DSDT bugs are often subtle: first, everything seems to work, but then you get
random lockups or failures which you can't really explain. Bad.

-- 
Stefan Seyfried



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
