From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Debug messages XE3 HP
Date: Tue, 4 Feb 2003 10:39:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030204093953.GD1205@poup.poupinou.org>
References: <001601c2cbd4$36d48d80$03c4a8c0@vrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <001601c2cbd4$36d48d80$03c4a8c0-a3AIZ4dZ1BE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Robert <robert-2BgBnwcziRhmR6Xm/wNWPw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 03, 2003 at 11:33:02PM +0100, Robert wrote:
> Can anyone use these debug lines ?
> 
> regards
> 
> Robert de Vrey
> 
> 
> 
> > Jan 27 23:47:22 Laptop kernel:  exfldio-0121 [310] ex_setup_region       :
> > Field [ACPW] Base+Offset+Width 38+0+4 is beyond end of region [GPIO]
> (length
> > 3B)
> > Jan 27 23:47:22 Laptop kernel:  psparse-1102: *** Error: Method execution
> > failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node cf75de08), AE_AML_REGION_LIMIT
> > Jan 27 23:47:22 Laptop kernel: acpi_battery-0195 [294]
> acpi_battery_get_statu:
> > Error evaluating _BST
> > Jan 27 23:47:22 Laptop kernel:  exfldio-0121 [310] ex_setup_region       :
> > Field [ACPW] Base+Offset+Width 38+0+4 is beyond end of region [GPIO]
> (length
> > 3B)
> > Jan 27 23:47:22 Laptop kernel:  psparse-1102: *** Error: Method execution
> > failed [\_SB_.PCI0.LPCB.BAT1._BST] (Node cf75de08), AE_AML_REGION_LIMIT
> > Jan 27 23:47:22 Laptop kernel: acpi_battery-0195 [294]
> acpi_battery_get_statu:
> > Error evaluating _BST
> >

It say that your laptop have the (in)famous bug where a buffer with a
bad size region is declared in the DSDT.
FYI, this one is manufactured by Compal Inc. which make this error all the time
(grumble grumble).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
