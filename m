From: Jan Frey <jfrey-Mmb7MZpHnFY@public.gmane.org>
Subject: ACPI throttling to death?
Date: Mon, 4 Apr 2005 22:14:15 +0200
Message-ID: <200504042214.15648.jfrey@gmx.de>
Reply-To: jfrey-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I'm observing strange behaviour with a Gericom notebook running a 2.6.9 
vanilla kernel with custom configuration. The processor used is a P III 
(Tualatin) with 1.2GHz (which is quite rarely used). It is *not* a mobile 
processor (no speedstep etc.), instead it supports 16 throttling levels.

Sometimes (I guess when the machine is getting overheated - the notebook 
design is really bad and the fan is quite lousy) ACPI temperature monitor 
shows >70 degrees (Celsius) and the system starts throttling.

Until here everything is fine IMO.
But what happens next is that the systems slows down continuously (you can 
monitor the current throttling level going up and up) until it reaches the 
last level (12%). Soon after that the whole machine is locked up hard, 
display still showing the current graphics. I guess it throttled to a 
"deathly" 0%...

Is this more a linux acpi problem or a fault in this particular machine?
What could be done about it? how can I debug further?

Thanks for any hints,
jan

-- 
Jan Frey
jfrey-Mmb7MZpHnFY@public.gmane.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
