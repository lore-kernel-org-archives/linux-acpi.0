From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI resume fails on HP nx6125 with 64 bit kernel
Date: Tue, 16 Aug 2005 17:11:42 +0200
Message-ID: <20050816151142.GA516@openzaurus.ucw.cz>
References: <20050815193848.GB17525@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050815193848.GB17525-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Attempting to resume an HP nx6125 results in the system hanging with a
> blank screen. Hacking serial setup code into wakeup.S so I can get
> serial console on resume gives me:

Can we get copy of those hacks?

> Back to C!
> arch/x86)64/mm/init.c:146: bad pte ffff810001543f38(80000000fec01173)
> 
> and no further output. The kernel never seems to get to device resume,
> so I guess the error is where it's blowing up. Any ideas? It seems to be
> independent of how long I leave the machine suspended. (This is a 64 bit
> kernel)

Does it work ok 32-bit?
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
