From: Jim Summers <jsummers-5f/76mLIbwCHXe+LvDLADg@public.gmane.org>
Subject: Learning ACPI
Date: Fri, 28 Jan 2005 14:24:51 -0600
Message-ID: <41FA9F93.4090105@cs.ou.edu>
Reply-To: jsummers-5f/76mLIbwCHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Listacpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hello List,

I have recently undertaken the project of getting power management under 
control on several of my faculty's laptops and other systems.  For the 
most part we are running on FC3 and Dell laptops.  My test machine is a 
  Dell Inspiron 5100 with the bios at the latest A32.

The first thing I noticed was that when the power button is pressed 
nothing happens.  Ignoring that, I was more interested in turning off 
the power to the lid when it was closed.

By remotely accessing the machine and monitoring the LID/state file I 
observed that indeed it was being updated properly (open or closed). 
But no events were firing off.  I placed a simple action to send a 
message to syslog via the logger utility and it never happens.  Also I 
never see any thing written to the acpid log file other than upon 
startup it loads two rules, the sample one for the power button and the 
one I put in for handling the lid event.

Looking through the DSDT database I noticed a mention of something 
called a lost interrupt for 5100's using the A26/28 bios.  I didn't 
think that was the issue since the state file was being updated correctly.

Dmesg output looks good for ACPI stuff.

Can someone give me some ideas on what the problem might be?

I guess I am not understanding how, if the acpid is correctly monitoring 
the lid state then why would it not fire the events/actions?  I can 
porvide more info, dmesg output etc...

TIA
-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
