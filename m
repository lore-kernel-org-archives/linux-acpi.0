From: "Nicholas Mistry" <nick-acpi-rrCFhXTPMk0L0swiZSXcMb5dPsmED6B0@public.gmane.org>
Subject: newbie question:  building w/ CONFIG_ACPI_SLEEP on 2.5.40+
Date: Thu, 17 Oct 2002 14:30:10 -0400 (EDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <2203.63.214.83.221.1034879410.squirrel@65.85.27.130>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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


I am relatively new to the ACPI implementation in linux, and was trying to
build my 2.5.40kernel w/ the acpi-20021002-2.5.40.diff.gz patch.  I first compiled the
kernel with thedefault options for ACPI and all ran perfectly.  Pressing the button
yeilded :
[...]
received event "button/power PWRF 00000080 00000003"
[...] completed event
"button/power PWRF 00000080 00000003

The one thing i noticed is that i cannot enable the
CONFIG_ACPI_SLEEP option.  I have tried trough make
(config|menuconfig|xconfig), andafter i select "Y", the option returns back to the default state of "N".

I am wonering if
there are some options that are required to be (un)set for this option to
work.
Thanks in
advance.

-N




-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
