From: Jeroen Wijnhout <Jeroen.Wijnhout-sVbgdUKTYbrR7s880joybQ@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 04 Jan 2005 08:47:49 +0100
Message-ID: <200501040847.49975.Jeroen.Wijnhout@kdemail.net>
References: <20041231092156.GA612@phys.ethz.ch>
 <20050103180219.GX19199@poupinou.org> <41D9A1F5.1060508@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <41D9A1F5.1060508-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Content-Disposition: inline
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

On Monday 03 January 2005 20:50, Pedro Venda wrote:
> another thing: I changed the current drain from "mA or mWh" to "mAh or mW"
> in smartbattery.c but I'm having some doubts:
>
> Are these energy or power measures?
> for power measures, the units would be mA/h or mW
> for energy measures, the units would be mA or mW.h
>
> so, maybe I changed it wrong... care to comment?

This puzzled me actually. mA is not the same as mW.h, unless you specify a 
reference voltage and time (but without specifying those it is meaningless). 
mA is a current (charge per second), mWh is energy.

mA/h is the unit that corresponds to change in the current. mAh has the unit 
of charge. It could very well be that the SMBus smartbattery specification 
has some reference values that allow you to convert mA/h to mW and mA to 
mW.h. But as it stand it really does not make sense to me.

best,
Jeroen
-- 
Kile - an Integrated LaTeX Environment for KDE
http://kile.sourceforge.net


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
