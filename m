From: nicdev05 nic <nicdev05-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: Driver Testing
Date: Fri, 18 Mar 2005 09:57:43 -0800 (PST)
Message-ID: <20050318175743.66629.qmail@web31406.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-628715756-1111168663=:63631"
In-Reply-To: 6667
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jason Dagit <dagit-LP0vGzdgvNwj5TC/SZClsA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--0-628715756-1111168663=:63631
Content-Type: text/plain; charset=us-ascii

Playing around more on the below problem, it appears that a ACPI module (button.ko) seems to have some issues and it causes the reboot. I am yet to dig deeper into what the exact issue might be, but removing this module before going into a suspend mode and then following with a resume works fine i.e. there is no reboot of the system on resume. Again this is on Fedora-2 system (with 2.6.5 kernel)
-Nic



> Outside of resume, the suspend process works fine
> (by writing to /sys/power/state). If I press the power
> button the system seems to resume but then follows
> with a reboot...

If you reboot on resume you may be experiencing this bug:
http://bugme.osdl.org/show_bug.cgi?id=3691


		
---------------------------------
Do you Yahoo!?
 Yahoo! Small Business - Try our new resources site! 
--0-628715756-1111168663=:63631
Content-Type: text/html; charset=us-ascii

<DIV>Playing around more on the below problem, it appears that a ACPI module (button.ko) seems to have some issues and it causes the reboot. I am yet to&nbsp;dig deeper into what the exact issue might be, but removing this module before going into a suspend mode and then following with a resume works fine i.e. there is no reboot of the system on resume. Again this is on Fedora-2 system (with 2.6.5 kernel)</DIV>
<DIV>-Nic<BR></DIV>
<P class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid"><BR>&gt; Outside of resume, the suspend process works fine<BR>&gt; (by writing to /sys/power/state). If I press the power<BR>&gt; button the system seems to resume but then follows<BR>&gt; with a reboot...<BR><BR>If you reboot on resume you may be experiencing this bug:<BR>http://bugme.osdl.org/show_bug.cgi?id=3691<BR></P><p>
		<hr size=1>Do you Yahoo!?<br> 
Yahoo! Small Business - <a href="http://us.rd.yahoo.com/evt=31637/*http://smallbusiness.yahoo.com/resources/">Try our new resources site!</a> 
--0-628715756-1111168663=:63631--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
