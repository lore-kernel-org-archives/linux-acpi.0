From: Cristian Cimpianu <cristian.cimpianu-oe7qfRrRQffoK229JIzMLneTipRkpopC@public.gmane.org>
Subject: Re: armada 1750
Date: Sat, 10 Apr 2004 15:35:41 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404101535.41246.cristian.cimpianu@student.kuleuven.ac.be>
References: <37F890616C995246BE76B3E6B2DBE0554F2353@orsmsx403.amr.corp.intel.com>
Reply-To: cristian.cimpianu-oe7qfRrRQffoK229JIzMLneTipRkpopC@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE0554F2353-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
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

> Well, _DIS isn't supposed to return a value anyway -- so don't worry
> about the warnings.

I'm not. I'm worried about not having control on the fan and the temperature 
sky-rocketing when it's off.

> You have to admit, this code is a bit funky:

if I knew exactly what it does, I would. right now I'm only beginning to 
understand bits and pieces. The 7 _DIS methods I find in the code I found out 
are disabling the respective devices which they belong to. So my main 
question is how do I remove C2 from processor.c as B.Schmidt says here:
http://acpi.sourceforge.net/dsdt/view.php?id=168
I found the bug on bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=2134 
so someone else has it too and didn't find a solution. H e didn't try without 
C2 I guess.

Cristian. 

-- 
http://sonty.go.ro


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
