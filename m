From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 3 Jan 2005 18:54:49 +0100
Message-ID: <20050103175449.GW19199@poupinou.org>
References: <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D95CDC.8050802@phys.ethz.ch> <41D95F53.5000008@tiscali.be> <41D967B5.7040002@tiscali.be> <Pine.LNX.4.60.0501031751590.5329@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0501031751590.5329-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Cc: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 03, 2005 at 06:02:59PM +0100, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> I did not look into the source... but usually the times are calculated:
> You take the capacity (remain-value) and divide it by the current. As the 
> ACPI-1.0 spec only asks for a current-value, if you use a 
> rechargable-battery and if this is in discharging-mode, you see, that they 
> did only, what the specs asked as a minimum.  I am not sure, if the 
> current-value would not need to be -1, if it is unknown however.
> So it is quite clear, that dividing something (especially if this itself 
> is not zero) by zero will give you an +overflow... with MAX_UINT (65535 
> for 16bit) is the nearest representable value.
> 

I'm much more a lazy man than that and much prefer to get those values
from the sensor ;)
The current is an int but it should be a short and is negative
if discharging.  Look at smartbattery data spec at
http://www.sbs-forum.org/specs/index.html

And the 2 times given was the same actually.  It's now corrected.

But as said, it's a first shot and smartbattery.c will soon be dead.

Problem is: from the ASL, there is 2 Smart Batteries and a Smart Battery
Selector (or a Smart Battery Manager).
I can go for the easy path at least for the smartbattery, since there is
already a driver for it in lm-sensors-2.9.0.  But actually there may be more
than one battery that can be reached at the same address, then I'm for
sure that the smartbattery stuff from lm-sensors can not handle multiple
batteries.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
