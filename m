From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Interpretation of ACPI spec?
Date: Thu, 20 Jan 2005 11:35:24 -0500
Message-ID: <41EFDDCC.1060707@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all --

I've just sent the message below to the email address (info-4kSll71tZrRhl2p70BpVqQ@public.gmane.org) 
given on the ACPI homepage for questions, comments, etc. And I've just 
received back a Host Unknown error.

Does anyone know whom I should contact for an interpretation on the 
specification?

cheers,

Rich

---CUT HERE---

Dear Sirs,

I am currently implementing a Linux driver for the Smart Battery 
sections of the ACPI specification. I am writing to request 
clarification of the specification regarding Alarm Notify events issued 
by Smart Batteries.

The Smart Battery Data specification indicates that such events, 
typically triggered by low charge capacity or hardware failures, will be 
sent over the SMBus to the host at address 0x08. However, the ACPI 
specification is unclear what then happens to these events.

Indeed, the specification discusses what happens to Alarm Notify events 
from a Smart Battery Charger (section 10.1.1.2) or a Smart Battery 
System Manager/Selector (sections 10.1.1.3 & 10.1.1.4). However, the 
discussion of Smart Battery objects (section 10.1.2) makes no mention of 
the handling of Alarm Notify objects.

Please could you clarify

a) how I should detect Alarm Notify events dispatched by Smart Batteries

and

b) how I should determine which particular batteries issued the events

Many thanks for your assistance,

Dr Richard Townsend
Bartol Research Institute
University of Delaware


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
