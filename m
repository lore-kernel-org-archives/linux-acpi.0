From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: New SmartBattery DSDT-based controller
Date: Sun, 30 Jan 2005 15:31:43 +0100
Message-ID: <20050130143143.GA368@hell.org.pl>
References: <41FBDDE2.1050403@bartol.udel.edu> <m27jlvx3i3.fsf@phoenix.squirrel.nl> <41FC2022.2080804@bartol.udel.edu> <m2mzur6zt6.fsf@phoenix.squirrel.nl> <41FCE348.3010304@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Rich Townsend:
> internet; but I got a nasty reminder last night. I ran my battery to 
> empty, to see which smart battery alarms went off (disappointing; there 
> were no alarms triggered, and only a single warning flag was set ~5 secs 
> before empty). Unfortunately, this procedure led to the loss of ~3% of 
> my battery capacity.

While it's possible, it's very unlikely. More probably your fuel gauge just
recalibrated itself to compensate for the gradual capacity loss. While it's
true Li-Ion cells don't like to be completely discharged, it's hardly
possible to do so under normal conditions. The power requirements of a
typical notebook cause the current to be cut off before the cell voltage
drops below the dangerous level. That said, the capacity also degrades with
time, temperature and the number of charges, so any of these could be
involved.

Standard disclaimer: the above is not meant to be authoritative.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
