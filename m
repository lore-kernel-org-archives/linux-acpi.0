From: Diego SANTA CRUZ <dsanta-W/9V78bTXrinCNX9eg9BBA@public.gmane.org>
Subject: RE: Processor C states and USB problem
Date: Mon, 19 Jan 2004 11:20:51 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074507651.9141.12.camel@ltspc67.epfl.ch>
References: <3ACA40606221794F80A5670F0AF15F8401720CE2@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CE2-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-01-18 at 04:17, Yu, Luming wrote:
> > 
> > Yes, but compared to the usage count of C2 that is extremely low, and
> > the CPU is idling all the time (CPU usage is below 1%). I don't know
> > much about C states but I guess it should go into C3 much more often,
> > and the bus mastering activity should show something else 
> > than ffffffff
> > when booting with a bare bones kernel and with no extra hw initialized
> > (USB, FireWire, etc.)
> 
> I agree that it's unreasonable that C3 usage count is never above 5. 
> This is the result of the C state power policy. 

Thanks for the explanations, it is more or less what I had understood
from reading processor.c last week. But my bottom line question was more
of the sort "why is there constant bus mastering activity if almost no
hardware is initialized", as I understand it is the bus mastering
activity that's preventing the use of C3.

Is there a not-so-complicated way to find out which subsystem is the
culprit for the bus mastering activity? As reported elsewhere in this
thread, it appears to be that this issue appears under 2.4 and not 2.6
(provided no USB mouse is plugged). I have not tested 2.6 on my laptop
yet, only 2.4.

Best,

Diego

> 
> Threshold is:
> pr->power.states[ACPI_STATE_C2].promotion.threshold.bm = 0x0F;
> pr->power.states[ACPI_STATE_C3].demotion.threshold.bm = 0x0F;
> 
> The condition of promotion or demotion is:
> if (pr->power.bm_activity & cx->demotion.threshold.bm) {
> if (!(pr->power.bm_activity & cx->promotion.threshold.bm)) {
> 
> Using the following statement to adjust bm_activity of the last Nth
> schedule quanta.
> 
> pr->power.bm_activity <<= 1;
> if(bm_status)
> 	pr->power.bm_activity++;
> 
> So it's is not strange that C3 usage count is 4  !
> 
> Maybe we need a more sophisticated policy .
> 
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
Diego SANTA CRUZ <dsanta-W/9V78bTXrinCNX9eg9BBA@public.gmane.org>
Ecole Polytechnique Fédérale de Lausanne - EPFL



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
