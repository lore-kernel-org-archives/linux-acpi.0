From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: first shoot for smartbattery (was Re: Re: i2c-acpi-ec.c)
Date: Sat, 01 Jan 2005 14:21:10 -0500
Message-ID: <41D6F826.8090906@neggie.net>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041231181628.GL19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Do you think your driver can be used to reset battery pack state?

I replaced the cells in my Toshiba battery pack, but the "last full 
capacity" is still stuck at the value from the old cells, and the 
"remaining capacity" seems to get clamped to this low value.  I heard 
that it might be possible to reset this using i2c.

Regards,
-John


Bruno Ducrot wrote:
> On Fri, Dec 31, 2004 at 04:07:24PM +0100, Bruno Ducrot wrote:
> 
>>I'm polishing i2c-acpi-ec right now.  Stay tunned.
> 
> 
> It's not yet really polished as I wanted, but well I don't have
> time to finish this due to, huh, ..., private stuff this night.
> 
> its should give people rough idea what will happens.
> 
> You can find this at http://www.poupinou.org/acpi/smartbatt/
> Take one of the smartbatt.tar.{gz,bz2} and follow the README after
> unpacking it, and hopefully a ./smartbatt will give you correct battery
> informations (who knows).
> 
> happy new year!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
