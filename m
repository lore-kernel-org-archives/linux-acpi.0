From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Fwd: ACPI error when trying entring in Sleep Mode]
Date: Mon, 17 Mar 2003 14:48:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030317134809.GF8319@poup.poupinou.org>
References: <3E75C4A6.6000507@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3E75C4A6.6000507-nc/lrvXPQ4s@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 17, 2003 at 01:50:46PM +0100, Marci wrote:
> No Ideas?
> 
> Please :(
> 
> I need this
> 
> Thanks again

> From: Marci <voloterreno-nc/lrvXPQ4s@public.gmane.org>
> To:  acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: ACPI error when trying entring in Sleep Mode
> 
> Hi all, here my configuration :
> 
> MSI KT4 Ultra
> 
> Athlon XP 2400+
> 
> Nvidia Geforce 3 Ti200
> 
> 
> I have this problem:
> 
> When I try to enter in S1 sleep mode appears in the screen these errors:
> 
> Mar 16 21:08:17 magisystem kernel:  exfldio-0129 [31] ex_setup_region 
>     : Field [U1PE] access width (2 bytes) too large for region [UBP1] 
> (length 1)
> Mar 16 21:08:17 magisystem kernel:  exfldio-0140 [31] ex_setup_region 
>     : Field [U1PE] Base+Offset+Width 0+0+2 is beyond end of region 
> [UBP1] (length 1)
> Mar 16 21:08:17 magisystem kernel:  dswexec-0421 [23] ds_exec_end_op 
>     : [Store]: Could not resolve operands, AE_AML_REGION_LIMIT
> Mar 16 21:08:17 magisystem kernel:  psparse-1121: *** Error: Method 
> execution failed [\_PTS] (Node c15bc5e8), AE_AML_REGION_LIMIT
> Mar 16 21:08:17 magisystem kernel:  hwsleep-0257 [15] 
> acpi_enter_sleep_state: Entering sleep state [S1]
> Mar 16 21:08:17 magisystem kernel:    evgpe-0351: *** Error: 
> acpi_ev_gpe_dispatch: No handler or method for GPE[00], disabling event
> Mar 16 21:08:18 magisystem kernel:  exfldio-0129 [32] ex_setup_region 
>     : Field [U1PE] access width (2 bytes) too large for region [UBP1] 
> (length 1)
> Mar 16 21:08:18 magisystem kernel:  exfldio-0140 [32] ex_setup_region 
>     : Field [U1PE] Base+Offset+Width 0+0+2 is beyond end of region 
> [UBP1] (length 1)
> Mar 16 21:08:18 magisystem kernel:  exfldio-0129 [32] ex_setup_region 
>     : Field [U1PE] access width (2 bytes) too large for region [UBP1] 
> (length 1)
> Mar 16 21:08:18 magisystem kernel:  exfldio-0140 [32] ex_setup_region 
>     : Field [U1PE] Base+Offset+Width 0+0+2 is beyond end of region 
> [UBP1] (length 1)
> Mar 16 21:08:18 magisystem kernel:  psparse-1121: *** Error: Method 
> execution failed [\_WAK] (Node c15bc768), AE_AML_REGION_LIMIT
> Mar 16 21:08:18 magisystem kernel:  hwsleep-0428: *** Error: Method _WAK 
> failed, AE_AML_REGION_LIMIT
> Mar 16 21:08:18 magisystem kernel:    evgpe-0351: *** Error: 
> acpi_ev_gpe_dispatch: No handler or method for GPE[00], disabling event
> 
> Anyone have ideas?
> 
> The command that I do is "echo 1 > sleep" in the /proc/acpi directory. 
> The kernel is the 2.4.21-pre4 with the lastest patch.
> The system is the Linux Debian Sid OS
> 

There is an error in your DSDT.  I don't doubt that if you
follow the instruction in
http://acpi.sourceforge.net/wiki/index.php/HowToOverrideTable

you will get a complain from iasl with a inproper declaration of
an operational region.  Check first if you can increase the size
for this region will be sufficiant.  If not, then do not hesitate
to request more help!

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
