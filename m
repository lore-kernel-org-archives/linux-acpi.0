From: Mike Wohlgemuth <mjw-JUfvz9/eqXCsTnJN9+BGXg@public.gmane.org>
Subject: ACPI vs. PCMCIA on Compaq Evo N800c
Date: Sat, 26 Apr 2003 20:52:50 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EAB29E2.5030702@woogie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'm trying to get ACPI working on my Compaq Evo N800c.  Actually, I 
should say that I have it working, or at least it's loading and I'm 
seeing entries in /proc/acpi, but whenever I boot with a kernel with 
ACPI enabled, it breaks PCMCIA.  The drivers attempt to load, but can't 
find the cardbus controller, which doesn't even show up in lspci.  Is 
this a common problem?  I've tried about 3 different kernel versions 
with both the stock ACPI and the patches from sourceforge, and they all 
behave the same way.  Any tips on where I should look to find a fix?

Thanks
Mike



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
