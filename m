From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI and Shutdown on VAIO FXA-49
Date: Tue, 19 Nov 2002 16:05:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021119150555.GG691@poup.poupinou.org>
References: <OFAB043F25.ED68D0AA-ON87256C75.005A19E8@us.ibm.com> <003f01c28f34$bab06930$e90015ac@HHN.INC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <003f01c28f34$bab06930$e90015ac-FbVwfWZXBtM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Russ Neff <russ-rjAkyXQP36HLeiHq/WgCfg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 18, 2002 at 02:00:14PM -0500, Russ Neff wrote:
> Hello,
>  I am running the 9.18.2002 patch on a stock 2.4.19 kernel on a Sony VAIO
> FXA-49 (Mandrake 9.0). I do seem to have a fan control and temperature
> regulation as well as battery and ac adapter status  (a lot more than I had
> before). My problem is that as soon as I patch the kernel I cannot
> completely power off (screen goes black but power is still on) and a reboot
> will cause my system to hang at the bios flash screen with the HDD LED on
> solid. Any ideas ?
> 

Could you please send a dmesg?  Did you also compile with apm stuff (the
two are not compatible and you have to make a choice) ?

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
