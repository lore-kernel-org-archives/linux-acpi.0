From: Oeystein Olsen <oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org>
Subject: Re: Acpi on compaq evo N1000v
Date: Sat, 10 May 2003 18:01:46 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305101801.46485.oystein.olsen@astro.uio.no>
References: <200305091147.15007.oystein.olsen@astro.uio.no>
Reply-To: oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200305091147.15007.oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Followup to my own post now.

I've finally gotten battery status on my laptop:-) Acpi seems to fully 
functional now. I solved my last problems by looking at how dsdt-table from 
evo N800v and presario 2800T loaded. I was rather suprised to see that the 
presario-table produced battery-status. Hence I rewrote parts of my original 
dsdt-table to reflect the battery part in the presario table and bingo! I 
still get these errors at boot though:
>
> psparse-1121: *** Error: Method execution failed
> [\_SB_.C03B.C04E.C0CF.C0D3] (Node c185e728), AE_NOT_EXIST
>
> Method execution failed [\_SB_.C03B.C04E.C0CF._INI] (Node c185b6a8),
> AE_NOT_EXIST
>
> nsinit-0397 [06] ns_init_one_device    : \_SB_.C03B.C04E.C0CF._INI failed:
> AE_NOT_EXIST
>
>  .........................................evrgnini-0261: *** Error: Could
> not install pci_config handler for C03B, AE_ALREADY_EXISTS
>
 
but I'm happy for now.

-- 
Øystein Olsen, oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, http://folk.uio.no/oeysteio
Institute of Theoretical Astrophysics, http://www.astro.uio.no
University of Oslo, Norway









-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
