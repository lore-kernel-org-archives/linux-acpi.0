From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: PCI IRQ routing strangeness with 2.4.22 on A7N266-VM (original nForce)
Date: Sat, 30 Aug 2003 13:02:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200308301302.39565.adq_dvb@lidskialf.net>
References: <20030829045032.GA688@gambit.implode.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030829045032.GA688-XxA8UMA2PDBPKbTXaf03yKxOck334EZe@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Wong <kernel-AAfBIQCtFhbR7s880joybQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Pin 2-16 already programmed
>     ACPI-1121: *** Error: Method execution failed [\_SB_.SRS_] (Node
> cdf363c0),
> AE_AML_BUFFER_LIMIT
>     ACPI-1121: *** Error: Method execution failed [\_SB_.LNKE._SRS]
> (Node cdf36dc0), AE_AML_BUFFER_LIMIT

Hi, first of all, my apologies to everyone for the long hiatus in IRQ routing 
patches from me... I've been really busy with other projects.

Secondly, I know what this is. I have a patch for it already. I will send it 
once I've ported it to the latest kernels (and tracked down which machine I 
was developing it on :)

Also, I should be able to fix the issues people were having with KT400s... VIA 
are being quite helpful.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
