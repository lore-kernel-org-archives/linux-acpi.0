From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: fyi about wakeup problem on Acer TM630
Date: Thu, 19 Jun 2003 11:55:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030619095554.GQ19556@poupinou.org>
References: <Pine.LNX.4.33.0306161111480.24923-100000@godzilla.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0306161111480.24923-100000-Hi2dXqvvzfF3Mq0XhIy4CVaTQe2KTcn/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 16, 2003 at 11:15:51AM +0200, Bjorn Wesen wrote:
> I noted that the travelmate freezes upon resume, but after the "Back to C!" 
> printout, so apparently the kernel came back alive ok. 
> 
> After some searching, I found that it completely freezes (no magic sysrq 
> etc) when running the _WAK ACPI method, and inside the _WAK method it hangs 
> on calling a GPE method called _L26 which I have pasted below. OSTP is 0, I 
> think, but I haven't gone that deep yet. Regardless, does anyone have a clue 
> on what they are trying to do below ? OSTP is 0 or 2 for detecting Microsoft 
> Windows or Microsoft WindowsME (1 or 3 for NT or XP). It seems they are 
> doing something to the IDE and/or floppy controllers, but are they toggling 
> power or something else ? Assuming it really is the first block which is run 
> (I forced OSTP to 0 because I dont run Windows :) there is nothing that 
> should freeze it except for the actual fiddling with those IDE registers..
> 

Most likely they turn on/off DMAs (but hard to tell without the
whole ASL and the whole spec of the IDE part).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
