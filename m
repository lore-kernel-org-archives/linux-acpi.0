From: Andre Kalus <akalus-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Boot failure on 2.6.0-test4/test5
Date: Mon, 15 Sep 2003 10:18:00 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2003.09.15.08.17.58.812498@gmx.de>
References: <20030915021622.GA1138@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

On Mon, 15 Sep 2003 04:16:22 +0200, Jordi Mallach wrote:

> Hi,
> 
> I just found out that ACPI was the cause for 2.6.0-test4 and test5's
> boot failures in my box. If I boot with acpi=off, it manages to boot. If
> not, the last message printed is
> mice: PS/2 mouse device common for all mice
> 

Hi,

I seem to have the same problem: 2.6.0-test3 worked with ACPI well,
test4 required pci=noacpi to boot and test5 finally dies if I do not
specify acpi=off.

The Hardware is a Gericom X5 Notebook with a VIA P4X Chipset.

With test6 will it get better or can it even get worse? ;-)

Greetings
Andre



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
