From: Jes Sorensen <jes-UC6nUKlm/0l5V+5IkYBVeNBPR1lH4CV8@public.gmane.org>
Subject: Re: [patch] 2.6.1-mm3 acpi frees free irq0
Date: 15 Jan 2004 17:01:51 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <yq0d69k27n4.fsf@wildopensource.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC89CC@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC89CC-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: akpm-3NddpPZAyC0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jesse Barnes <jbarnes-sJ/iWh9BUns@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>>>>> "Len" == Brown, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:

Len> The primary failure is that the SCI was not found, and the
Len> secondary symptom is that we failed to handle that error properly
Len> -- which you've patched.

Len> Can you tell me more about the primary failure?  Was the SCI
Len> found in other releases?

Hi Len,

In this specific case the prom doesn't have it in it's tables, so not
finding it is expected behavior.

Cheers,
Jes


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
