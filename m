From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: ACPI throttling to death?
Date: Tue, 5 Apr 2005 16:38:20 +0000
Message-ID: <200504051638.22705.stefandoesinger@gmx.at>
References: <200504042214.15648.jfrey@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200504042214.15648.jfrey-Mmb7MZpHnFY@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jfrey-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Montag, 4. April 2005 20:14 schrieb Jan Frey:
> Hi,
>
> I'm observing strange behaviour with a Gericom notebook running a 2.6.9
> vanilla kernel with custom configuration. The processor used is a P III
> (Tualatin) with 1.2GHz (which is quite rarely used). It is *not* a mobile
> processor (no speedstep etc.), instead it supports 16 throttling levels.
>
> Sometimes (I guess when the machine is getting overheated - the notebook
> design is really bad and the fan is quite lousy) ACPI temperature monitor
> shows >70 degrees (Celsius) and the system starts throttling.
>
> Until here everything is fine IMO.
> But what happens next is that the systems slows down continuously (you can
> monitor the current throttling level going up and up) until it reaches the
> last level (12%). Soon after that the whole machine is locked up hard,
> display still showing the current graphics. I guess it throttled to a
> "deathly" 0%...
>
> Is this more a linux acpi problem or a fault in this particular machine?
> What could be done about it? how can I debug further?
My desktop machine locked up if it got to hot(70-75 degrees, amd duron 
processor). I bought a better CPU fan and the problem is gone. Well, that's 
impossible on notebooks.

Is there a 0% throttling level? What happens if you stop processor hungry 
tasks to allow the machine to cool down?

Stefan


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
