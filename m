From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: RE: preparing toshiba_acpi driver release
Date: Mon, 26 Jan 2004 14:48:40 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40156F18.8010202@neggie.net>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A4B@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A4B-N2PTB0HCzHJF3Yvz3xaN/VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Brown, Len wrote:
> In general, it it is best to have smaller patches which are single 
> logical changes so that they can be reviewed as a unit, tested as a 
> unit, and applied or un-applied as a unit. However, if the changes
> are small, grouping several together is fine.

Although my driver is bundled with the acpi subsystem, I maintain and 
support it independently.  The driver has a version that is independent 
of the acpi subsystem.  In the past, whenever a new version was ready, 
I'd release it to Andrew.  When a problem is reported to me, I want to 
be able to determine exactly what code I'm dealing with from the driver 
version.  For this reason, I'd prefer that you accept my changes as a whole.

> Also, if the patch applies both to 2.4 and 2.6, but the patch is 
> different, then I appresiate getting both patches rather than having
> to port the patch myself.

In the case of my driver, the same driver source is used in both kernels.

> Note that the strategy going forward is to create a generic
> acpi/video extensions driver that works on all platforms. When it is
> available, we should remove the video functionality from
> toshiba_extras and asus_extras. 
> http://bugzilla.kernel.org/show_bug.cgi?id=1944
 >
 > If anybody is excited about doing this, I'd be happy to work with a
 > volunteer.

I already responded about this on acpi-devel, saying I would tentatively 
take stab at it.

Regards,
-John


-- 
http:// if  ile.org/


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
