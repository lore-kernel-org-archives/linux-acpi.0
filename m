From: Diego SANTA CRUZ <Diego.SantaCruz-p8DiymsW2f8@public.gmane.org>
Subject: Re: Processor C states and USB problem
Date: Thu, 15 Jan 2004 09:06:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074153993.9113.6.camel@ltspc67.epfl.ch>
References: <3ACA40606221794F80A5670F0AF15F8401720CC9@PDSMSX403.ccr.corp.intel.com>
	 <1074066934.9124.6.camel@ltspc67.epfl.ch>
	 <20040114163437.4bcbc62f.mike@it-loops.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040114163437.4bcbc62f.mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-01-14 at 16:34, Michael Guntsche wrote:

> 
> Have you tried running a 2.6 kernel?
> Under 2.4 bus master always shows "ffffffff" on my notebook. Sometimes
> shutting down USB helps, sometimes it doesn't.
> Running under 2.6 I only get full bus master activity if an USB
> mouse is plugged in.
> 

Thanks for the info. I guess I should get myself to try it out sometime
soon then. The only problem is that the winmodem in this laptop uses a
binary driver not available for 2.6 (AFAIK).

Best,

Diego

-- 
-------------------------------------------------------
Diego Santa Cruz - PhD
Publications available at http://ltswww.epfl.ch/~dsanta
Signal Processing Institute (LTS1 / ITS / STI)
Swiss Federal Institute of Technology (EPFL)
EPFL - STI - ITS, CH-1015 Lausanne, Switzerland
E-mail:     Diego.SantaCruz-p8DiymsW2f8@public.gmane.org
Phone:      +41 - 21 - 693 26 57
Fax:        +41 - 21 - 693 76 00
-------------------------------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
