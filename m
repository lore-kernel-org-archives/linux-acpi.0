From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: New SmartBattery DSDT-based controller
Date: Sun, 30 Jan 2005 15:00:55 +0000
Message-ID: <1107097255.25905.25.camel@tyrosine>
References: <41FBDDE2.1050403@bartol.udel.edu>
	 <m27jlvx3i3.fsf@phoenix.squirrel.nl>	<41FC2022.2080804@bartol.udel.edu>
	 <m2mzur6zt6.fsf@phoenix.squirrel.nl>  <41FCE348.3010304@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41FCE348.3010304-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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

On Sun, 2005-01-30 at 08:38 -0500, Rich Townsend wrote:

> BTW, a warning for those with Smart Batteries (or, for that mattery, any 
> LiIon battery): you can damage your battery by running it all the way to 
> empty. I kind of knew about this already, from stuff I'd read on the 
> internet; but I got a nasty reminder last night. I ran my battery to 
> empty, to see which smart battery alarms went off (disappointing; there 
> were no alarms triggered, and only a single warning flag was set ~5 secs 
> before empty). Unfortunately, this procedure led to the loss of ~3% of 
> my battery capacity.

This is unlikely - the battery will prevent itself from being overly
discharged. However, LiIon batteries will lose some amount of capacity
over time anyway. What you're probably seeing is the battery
recalibrating itself (ie, you'd already lost 3% of capacity, and the
battery was just lying to you about how charged it was)

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
