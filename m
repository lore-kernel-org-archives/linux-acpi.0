From: Thorsten Zachmann <t.zachmann-c61pB8mzqkY@public.gmane.org>
Subject: Re: No handler for Region
Date: Wed, 4 Feb 2004 17:27:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402041727.44029.t.zachmann@zagge.de>
References: <200402030823.53848.t.zachmann@zagge.de> <20040203153411.M47846@morningdave.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040203153411.M47846-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: greg <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 03 February 2004 16:34, greg wrote:
> Hi Thorsten,
>
>    I had similar issues with a Gaateway 200X. The problem is that the
> machine does not supply an ECDT. I was able to fix the problem by using the
> patch associated with bug 1690.
>
> the bug - http://bugme.osdl.org/show_bug.cgi?id=1690
> the patch - http://bugme.osdl.org/attachment.cgi?id=1690&action=view
>
>    It seems to have worked for a number of different systems with this
> issue, so perhaps it will help you, too.

Thanks for pointing out. It help indeed. No all error messages during the boot 
are gone.

Thorsten


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
