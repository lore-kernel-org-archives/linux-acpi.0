From: Christian Krause <chkr-XkyyLUlAgJkb1SvskN2V4Q@public.gmane.org>
Subject: ACPI on GA-7VRXP - no C2 state
Date: 16 Oct 2002 23:24:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3it02axgq.fsf@gondor.middle-earth.priv>
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

Hi,

after changing my board+cpu to a gigabyte GA-7VRXP and Athlon 2000+
I noticed, that there is no C2 state any more.

I tried the following:
- 2.4.19 with included ACPI-Support:
/var/log/messages:
Processor[0]: C0 C1, 8 throttling states

- 2.4.19 with acpi-20020918-2.4.19.diff:
/var/log/messages:
ACPI: Processor [CPU1] (supports C1, 16 throttling states)

- later I increased the debuglevel:
debug output:
acpi_processor_get_pow: C2 latency too large [101]

What does this means and what can I do to get ACPI with C2 working?
(only C1 doens't reduce the CPU temperature on my system and with the
older board + older athlon C2 was working...)


regards,
christian



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
