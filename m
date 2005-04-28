From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Suspend2ram on Toshiba Tecra A3 OR problem with S3 on new 915PM chipset system appears to be with SATA/IDE
Date: Thu, 28 Apr 2005 17:43:26 +0200
Message-ID: <20050428154326.GA9097@message-id.gmane0305.slipkontur.de>
References: <200504272244.j3RMibEf032018@fnapcf.fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200504272244.j3RMibEf032018-vjLZTnyA75mSFZzDrWHoTA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 27, 2005 at 05:44:37PM -0500, Ron Rechenmacher wrote:

> So, which driver(s) should I look at?
> Or is there a simple chant to /proc that can wake up the disk correctly?
> Or am I not doing something correctly before/after I
>    echo mem >/sys/power/state
> Or is the 915PM and/or SATA acpi stuff just (too) new and I should help
> get it working?

The SATA drivers have no power-management support (i wonder how this could
happen, since they are brand new, but this is another story...). Jens Axboe
is fixing them up right now, you should be able to find patches for them on
LKML.

This does affect suspend to disk as well as suspend to RAM. Also, since it
seems timing sensitive, it works on some machines sometimes.
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
