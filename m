From: =?ISO-8859-2?Q?Krzysztof_Ol=EAdzki?= <ole-gcSpNFQc7Gg@public.gmane.org>
Subject: Re: Problem with ACPI-patch
Date: Wed, 25 Jun 2003 00:48:42 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0306250042270.12727-100000@dark.pcgames.pl>
References: <Pine.LNX.4.33.0306232244001.2066-100000@frog.athome>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0306232244001.2066-100000-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Mon, 23 Jun 2003 liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Salut list,
> there is one thing in the /proc/interrupts that is not right, and it is
> not a MP problem. I also got this with a single-processor board with
> ioapic.
> The point I mean is, that some PCI devices got an edge-driven IRQ, what is
> wrong (only the ones that are not connected through the XT-PIC). And
> surprise, this devices will not work this way :-((( Am I right Krzysztof?
Yes, network does not work but there is no problem with SCSI. Anyway,
since new ACPI is in standard linux kernel (2.4.22-pre1) soon it will be
no longer possible to use older version (20030228) of acpi subsystem.
Any chances for fix?

Best regards,

				Krzysztof Oledzki



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
