From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Power on at specific time
Date: Tue, 29 Apr 2003 22:51:26 +1200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1051613486.3508.48.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Andy.

A while ago we had a conversation that finished like this...


 > From: Nigel Cunningham [mailto:ncunningham-1uLG4q7jwdI@public.gmane.org] 
 > On Wed, 2003-02-19 at 13:09, Grover, Andrew wrote:
 > > Well, go fix it and send me a patch! :)
 > > 
 > > Seriously, Pat roughed-in the alarm support a long long 
 > time ago, but it
 > > needs someone to take another look at it and get it fully 
 > functional.
 > 
 > Gladly, but I wanted to make sure I wasn't barking up the wrong tree
 > first, and then I need a push in right direction (toward some
 > documentation!).
 
 Go check out include/linux/mc146818rtc.h. Using this plus the existing
 code plus a recent ICH datasheet available on developer.intel.com (I
 recommend ICH3m's - section 9.6 is "Real Time Clock Registers") you
 should be able to get started.
 
 Hope this helps -- Regards -- Andy


I'm having trouble finding the ICH datasheet you spoke of. Could you
give me a url?

Thanks in advance,

Nigel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
