From: Luca <kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org>
Subject: Re: [BUG][2.6.3-rc2] Unable to turn display on with ASUS L3D
Date: Fri, 13 Feb 2004 15:35:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040213143505.GA1575@dreamland.darkstar.lan>
References: <20040212161008.GA8729@dreamland.darkstar.lan> <20040212210807.GA23222@hell.org.pl>
Reply-To: kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040212210807.GA23222-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, julien.lerouge-GANU6spQydw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Il Thu, Feb 12, 2004 at 10:08:07PM +0100, Karol Kozimor ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> Thus wrote Luca:
> > echo 1 > /proc/acpi/asus/disp hangs the system but turns the lcd on.
> > These are the last lines I see (with debug_level = 0x000000ff):
> 
> Please boot with noapic or nolapic.
> There was a patch floating around that might have helped, search the
> bugzilla...

Thank  you for  the reply. I  made  other tests  and it  seems that  the
problem isn't ACPI related. LCD stays  off event without the ASUS stuff,
but goes on  using old sisfs driver with the  new acpi4asus driver. So I
guess that it's sisfb fault.

Luca
-- 
Home: http://kronoz.cjb.net
La mia opinione puo` essere cambiata, ma non il fatto che ho ragione.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
