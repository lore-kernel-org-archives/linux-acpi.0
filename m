From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Broken DSDT on Acer Travelmate 243LC
Date: Sun, 29 May 2005 22:03:10 +0200
Message-ID: <20050529200310.GG32472@poupinou.org>
References: <42997132.2050202@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42997132.2050202-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fabian Zeindl <fabian.zeindl-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, May 29, 2005 at 09:37:22AM +0200, Fabian Zeindl wrote:
> Hi
> 
> I decompiled my dsdt on my Acer Laptop and got 4 Errors:
> 
> dsdt.dsl   918:                         If (UPBI ())
> Error    1029 - Called method returns no value ^
> dsdt.dsl   923:                         If (UPBS ())
> Error    1029 - Called method returns no value ^
> dsdt.dsl  2513:                     Field (ERAM, AnyAcc, Lock, Preserve)
> Error    1048 -                               ^ Host Operation Region
> requires ByteAcc access
> dsdt.dsl  2611:                             Store (Arg2, DAT3)
> Error    1014 -    Method argument is not initialized ^  (Arg2)
> dsdt.dsl  2611:                             Store (Arg2, DAT3)
> Remark   3041 -   Not a parameter, used as local only ^  (Arg2)
> 
> I fixed the third one by changing "AnyAcc" to "ByteAcc",

Correct.

> and the fourth one by changing Store (Arg2, DAT3) to Store (2, DAT3).
> (is this right?)

Not correct.  I will extend the number of arguments passed to the method
instead.  But this method is never called, so I wont mind a lot.
that is:

--- dsdt.dsl	2005/05/29 19:50:18	1.1
+++ dsdt.dsl	2005/05/29 19:59:10
@@ -2586,7 +2586,7 @@
                         Return (DAT1)
                     }
 
-                    Method (RAMW, 2, NotSerialized)
+                    Method (RAMW, 3, NotSerialized)
                     {
                         Acquire (MUT0, 0xFFFF)
                         If (LGreater (Arg0, 0x7F))

> I don't know what to do with the first two errors, cause I don't which
> return values to give back in this functions.

I don't know.  But this method (CHBP()) where those errors happens
is never called, so I won't mind a lot.  And if really I would
need to overwritte this dsdt, I would comment this method.


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
