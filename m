From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: acpi & cpu cooling
Date: Thu, 20 Jan 2005 15:22:20 +0100
Message-ID: <20050120142213.GG476@openzaurus.ucw.cz>
References: <41E8E816.2050003@pl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41E8E816.2050003-tXhYEH5G0dc@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Morgan Read <mstuff-tXhYEH5G0dc@public.gmane.org>
Cc: ACPI devel list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> I've lurked on this list for a while & my questions seem a little
> elementary, but it seems this is the best place to ask?
> 
> My objective is to quieten my laptop (donated to me) so I can sit it 
> in lectures with out embarrassment or complaint from my fellow 
> students...
> 
> I've de-dusted the heat-sink & re set it.  But, it still spends most 
> of the time with the fan at full speed.

Just stick piece of paper into the fan so it can not spin and
see if passive cooling can deal with it :-).
 
> If I can throttle down the cpu it'll cool off and the fan will
> drop down to slow??? - My strategy.

Stop the fan and acpi should do just that.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
