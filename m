From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: Re: Bug in mm series
Date: Tue, 3 Feb 2004 13:48:55 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040203134855.664cc2dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Begin forwarded message:

Date: Tue, 3 Feb 2004 15:33:24 -0600 (CST)
From: Derek Foreman <manmower-KcrYKJX3CPLyydeieYBue0EOCMrvLtNR@public.gmane.org>
To: Luis Miguel Garc=EDa <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Cc: LINUX KERNEL MAILING LIST <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm@digeo.com
Subject: Re: Bug in mm series


On Tue, 3 Feb 2004, [ISO-8859-1] Luis Miguel Garc=EDa wrote:

> When I try to boot with latest mm series (such as actual rc3-mm1 or
> rc2-mm2), my nforce ethernet device doesn't works. It worked in the past
> with the forcedeth reverse engineered driver but now it keeps for 30 or
> more seconds halted (at boot) and then the network device dosn't run.
>
> Here is the dmesg of rc3-mm1. Do you want for me to test something? Thank=
s!
>
> P.S.:   The ACPI related messages are larger that in rc3.

My e100 on an nforce2 won't work in rc3-mm1.
The "acpi=3Doff" boot parameter makes it go.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
