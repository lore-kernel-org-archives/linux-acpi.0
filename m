From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: New SmartBattery DSDT-based controller
Date: Sun, 30 Jan 2005 08:38:16 -0500
Message-ID: <41FCE348.3010304@bartol.udel.edu>
References: <41FBDDE2.1050403@bartol.udel.edu>	<m27jlvx3i3.fsf@phoenix.squirrel.nl>	<41FC2022.2080804@bartol.udel.edu> <m2mzur6zt6.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2mzur6zt6.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:
> 
> 
>>The i2c device stuff doesn't work simultaneously because the original
>>SMBus controller section in the DSDT has been commented out.
> 
> 
> Okay, fixed. Everythng seems to be up an running, and both the new
> batery (hmm, am I experiencing character loss here, or is it my
> typing?) status and the i2c method give consistent results. Again,
> good work!

You probably *are* experiencing character loss. I still haven't fixed 
the problem that low-level EC access can sometimes lead to lost 
interrupts. I've tried to mitigate the problem by putting a 1ms sleep 
after each access, but that isn't perfect.

However, I'm glad you're getting consistent results with the i2c method.

> 
> While we're at it -- did you manage to control the fans? I can read
> the status, and write to it, but I do not hear a difference.

Nah, but I'll have a dig around.

BTW, a warning for those with Smart Batteries (or, for that mattery, any 
LiIon battery): you can damage your battery by running it all the way to 
empty. I kind of knew about this already, from stuff I'd read on the 
internet; but I got a nasty reminder last night. I ran my battery to 
empty, to see which smart battery alarms went off (disappointing; there 
were no alarms triggered, and only a single warning flag was set ~5 secs 
before empty). Unfortunately, this procedure led to the loss of ~3% of 
my battery capacity.

Maybe when I get the in-the-works SourceForge project going, I'll set up 
a PayPal donation fund for a new battery :).

cheers,

Rich

PS Overnight, I got a number of new DSDTs from various people; I'll be 
fixing these today and posting them on the website.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
