From: Andreas Schallenberg <Andreas.Schallenberg-0xiJHvB3xRZWk0Htik3J/w@public.gmane.org>
Subject: IRQ problem with Rhine II network card
Date: Fri, 3 Sep 2004 09:53:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409030953.02936.Andreas.Schallenberg@Eurobild.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello!

There is a problem using kernels from 2.6.6-rc3-bk8 on
which detect a different IRQ for the Rhine-II network card
on a HP Omnibook xe4100.

The issue does not seem to be related to the network card
driver since I used an old one (which works in a 2.6.4 kernel)
and used it in a 2.6.8.1 kernel and it fails to work.
Using ACPI kernel parameters can modify the behavior.

There is a website of a user from Finnland who also has
such problems using 2.6 kernels (I mailed to him) so I don't
expect it to be a hardware problem.

I created a bug report:
http://bugzilla.kernel.org/show_bug.cgi?id=3319
(Thanks to Roger Luethi who told me which tests to do)

Maybe this issue is related to:
http://bugzilla.kernel.org/show_bug.cgi?id=3234

Greetings,
Andreas
-- 
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
