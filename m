From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: Re: S4bios support for 2.5.63
Date: Fri, 07 Mar 2003 07:40:42 +1300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1046976042.1699.13.camel@laptop-linux.cunninghams>
References: <20030306072229.GA750@budgie.we1.client2.attbi.com>
 <20030306074226.GC750@budgie.we1.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030306074226.GC750-peapQs0eLv2IgHrOsx/gaWNy84NFWbr7VpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ken Hughes <khughes-kam3zbT8ll8@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2003-03-06 at 20:42, Ken Hughes wrote:
> I also noticed that when the suspend works, the "freeing memory: ....."
> messages prints out about 100 periods.  The first 20 or so come slowly,
> then it zips through most of the others.  When it oops's, it prints out
> about 15 or so periods before the panic.  This seems similar to what 
> Bert was
> saying in an earlier message:

This is because of the algorithm being used. 2.5 swsusp currently tries
to free as much memory as it can, and then writes the remainder to disk.
Freeing the memory can take quite a while. A port of the 2.4 code is in
progress (hopefully it will be accepted :>).

Regards,

Nigel



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
