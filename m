From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] invalid resource lists and extra checking
Date: Mon, 22 Sep 2003 16:53:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030922145315.GC13165@wotan.suse.de>
References: <20030918221109.L16619@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030918221109.L16619-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-jp-l7ZBCLq5RC066kwqclu8Pg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> --- rsaddr.c	13 Jul 2003 22:43:31 -0000	1.1.1.11
> +++ rsaddr.c	19 Sep 2003 04:59:50 -0000
> @@ -168,6 +168,10 @@
>      Buffer += 1;
>      ACPI_MOVE_16_TO_16 (&Temp16, Buffer);
> 
> +    /* Check for the minimum length. */
> +    if (Temp16 < 13)
> +        return_ACPI_STATUS (AE_AML_INVALID_RESOURCE_TYPE);

For which acpica version is this exactly? I tried to apply it to a Linux
tree which has nearly the latest, but it rejected on every hunk. 
The file is also repetive enough that hand applying looks a bit risky.

Can you perhaps post a patch against the latest ACPICA version?

-Andi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
