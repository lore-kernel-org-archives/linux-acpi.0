From: =?iso-8859-1?q?=D8ystein=20Olsen?= <oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org>
Subject: Re: strange behavior of ArgX variables in a ASL method
Date: Tue, 26 Aug 2003 21:58:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200308262158.13671.oystein.olsen@astro.uio.no>
References: <Pine.LNX.4.44.0308261730040.17349-100000@pc8-142>
Reply-To: oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0308261730040.17349-100000-BCD3+5vRDT8@public.gmane.org>
Content-Disposition: inline
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

On Tuesday 26 August 2003 18:22, Pierre Letouzey wrote:

> I tried to replace the second Store(Arg1, Local2) by a
> Substract(Local2, 0x1A, Local2), and that makes the errors disappear.
>

Thanks, that fixed my own dsdt-table for Compaq Evo N1000v. It's seems to b=
e a=20
problem on several laptops from compaq.

=2D-=20
=D8ystein Olsen, oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, http://folk.uio.no/oeysteio
Institute of Theoretical Astrophysics, http://www.astro.uio.no
University of Oslo, Norway




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
