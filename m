From: Mario Lang <mlang-0OxMAPPu35xAfugRpC6u6w@public.gmane.org>
Subject: Automatic adjustment of P and T states according to load?
Date: Wed, 06 Nov 2002 11:30:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <8765vbhtws.fsf@lexx.delysid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi.

I'm using my JVC laptop with ACPI-only under LInux.  I ended up
writing a little script, jslow and jfast, to set P1:T1 and P0:T0.
But it would really be more efficient if I could convince the
kernel to do adjustments of Throttling, and especially also
the Performance state if load is low or high.

Does the Linux ACPI code have any mechanisms for this which
I overlooked till now?  Or am I supposed to do such
things in userspace (cron every minute or so?)

Basicly, I'd like the CPU to drop to P1:T4 at least
if it is idle and doing nothing.  If I start to compile something for
instance, load would go up, and P1 would get set to P0 and T states
slowly decreased till 0.  If the load drops again, P1
should get activates, and T states slowly increase...

-- 
CYa,
  Mario


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
