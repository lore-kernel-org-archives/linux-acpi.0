From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: first shoot for smartbattery (was Re: Re: i2c-acpi-ec.c)
Date: Mon, 3 Jan 2005 14:13:41 +0100
Message-ID: <20050103131341.GN19199@poupinou.org>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <41D6F826.8090906@neggie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41D6F826.8090906-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 01, 2005 at 02:21:10PM -0500, John Belmonte wrote:
> Do you think your driver can be used to reset battery pack state?
> 
> I replaced the cells in my Toshiba battery pack, but the "last full 
> capacity" is still stuck at the value from the old cells, and the 
> "remaining capacity" seems to get clamped to this low value.  I heard 
> that it might be possible to reset this using i2c.
> 

This driver implement the ACPI smbus host controller interface via the
embedded controller as defined in ACPI 2.0c, 13.9.  If you don't have
that, it won't work.  AFAIK, there is no such smbus HC in any toshiba
with a toshiba bios.  But there is an 'hidden' one in the toshiba
satellite 3000-100, but for other models, I can't say for sure.

It might be possible that there is a smbus bios in your model.
For checking if this is the case, could you please try the
detection code at
http://www.poupinou.org/acpi/smartbatt/smbusbios.tar.gz

Of course, it will be fine if you send me the acpidmp.out.bz2 for your
model...

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
