From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: ACPI-Patch against 2.4.20-pre10-ac1
Date: 12 Oct 2002 00:50:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034380226.12709.1.camel@irongate.swansea.linux.org.uk>
References: <20021011183427.20a55d1c.hanno@gmx.de>
	<1034372783.12355.4.camel@irongate.swansea.linux.org.uk>
	<20021011225702.GA17690@tarnation.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021011225702.GA17690-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Aaron Gaudio <prothonotar-2LEdZMXKCZJeeLb3ft/vUmD2FQJk+8+b@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2002-10-11 at 23:57, Aaron Gaudio wrote:
> I use acpi and cpufreq on my Vaio r505 laptop. ACPI does not
> seem to be able to do cpu throttling on the system (it's a Pentium
> III-M if anyone's interested), but the modules for cpufreq handles
> it well (except when it first loads during boot it seems to be
> getting odd numbers in the proc files).

If the ACPI code for that laptop doesn't know how to handle it (or its
expecting native power management) then all should work ok. If the ACPI
code is also doing power management it might not pan out as beautifully
as we would like



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
