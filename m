From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Some failures
Date: Mon, 2 Dec 2002 18:38:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021202173834.GV1989@poup.poupinou.org>
References: <Pine.LNX.4.50.0212021428260.1091-100000@dot.kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212021428260.1091-100000-CpmL+rkjyb1AfugRpC6u6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bernhard Rosenkraenzer <bero-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 02, 2002 at 03:49:01PM +0100, Bernhard Rosenkraenzer wrote:
> Hi,
> I've just tried kernel 2.4.20-ac1 + the current (20021126) ACPI patch on 4 
> different boxes - one caused a fatal crash and 3 were somewhat working, 
> but missing suspend etc.:
> 
> On an ASUS A7S333 mainboard using the 1005.003 BIOS, the kernel produces 
> an oops at startup, when enabling IO-APIC IRQs:
> 

[cut]

I can not help for you here.

> On a QDI i810 based mainboard (don't have the full name - the board is 
> taken from a set top box ;) ), results are better, but not perfect - 
> bootup works, ACPI IRQ routing works, but sleep modes don't work -
> echo 1>/proc/acpi/sleep returns immediately without changing anything, 

You need to put some spaces.
echo 1 > /proc/acpi/sleep
NOT echo 1>....


> thouch /proc/acpi/sleep claims modes 0, 1, 4 and 5 are supported (5 
> actually works).

Only sleeping states 1 and 5 are supported with kernel 2.4.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
