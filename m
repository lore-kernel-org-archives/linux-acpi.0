From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: AMD Cool'n'Quiet
Date: Mon, 2 Feb 2004 11:08:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040202110818.011faac9.ak@suse.de>
References: <Pine.LNX.4.53.0402020255001.21219@ohzoyr.ybhtugba.zr.hx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.53.0402020255001.21219-ZITK3WZmtajxsQirvqX5VLrBFzj/CAxj@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Richard Smith <spam_if_you_want_to-/E1597aS9LT10XsdtD+oqA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2 Feb 2004 03:00:31 +0000 (GMT)
Richard Smith <spam_if_you_want_to-/E1597aS9LT10XsdtD+oqA@public.gmane.org> wrote:

> If I buy an AMD Athlon 64 CPU and an appropriate motherboard, will the
> Cool'n'Quiet feature work on Linux?  (This throttles down the CPU to
> reduce power consumption when idle.)  I know Windows requires special
> drivers.  Is it handled by ACPI on Linux?

It's handled by an own cpufreq driver (powernow-k8) independent of ACPI 
and works. However it requires a correct PST table from the BIOS, which is often
not there. You also need to run cpufreqd.

-Andi


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
