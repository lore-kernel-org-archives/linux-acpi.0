From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: RE: ACPI -- Workaround for broken DSDT
Date: Thu, 05 Feb 2004 12:34:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40222A37.6030401@basmevissen.nl>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8AB6-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Scott T. Smith" <scott-j3vAvQ9dNB9ByuSxxbvQtw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Brown, Len wrote:

> The strategy is to improve ACPI on Linux such that all Linux distros are
> able to successfully ship ACPI enabled kernels.
> 
> When we reach that stage, the OEMs will use these commercial Linux
> products when they validate their platforms -- fixing DSDT problems
> themselves before the 1st BIOS is released to the public.
> 
> Thus the long term strategy is for zero DSDT over-rides.
> 

Linux-ACPI will only become mainstream when it runs out-of-the-box on 
most computers. Until then, it will remain troublesome...

So the choice is to stick to the standard or to be smarter. Yes, it will 
not help fixing the DSDT's. But the only real solution to that is what 
I've written below.

> Re: what does windows do?
> Windows doesn't have to do anything.  By being first to ship ACPI, that
> implementation provided the defacto ACPI compliance test to which all
> BIOS' are tested -- even if that implementation is not ACPI spec
> compliant.  No, only under dire circumstances will we emulate Windows
> bugs in Linux.
> 

ACPI committee did not push a proper validation program. It's like the 
web "standards": standards are therem but everybody tests with IE and 
most web developers are satisfied when it works with it...

ACPI committee should make a proper validation mandatory before a 
computer may be sold as "ACPI X.Y compliant". Then manufacturers can 
test against (open) validation platform and Linux-ACPI can be validated 
against it too.

Bas.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
