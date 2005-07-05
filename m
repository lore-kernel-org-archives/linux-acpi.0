From: Rohit K Jhunjhunwala <agrawal_rocky-IRBnI7/bi/yuj8VC67ciSw@public.gmane.org>
Subject: not running any scripts
Date: Wed, 06 Jul 2005 02:28:46 +0530
Message-ID: <1120597126.4570.2.camel@roxie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ongW+AUNoeNc5EFo8x86"
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
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-ongW+AUNoeNc5EFo8x86
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

i tried doing cat /proc/acpi/event after stopping acpid and doing all
kind of things like closing lid and pressing power button.
it does not do anything and does not generate any event.
can anyone tell me the reason behind it..

thanx in advance.

--=-ongW+AUNoeNc5EFo8x86
Content-Disposition: inline
Content-Description: Forwarded message - [ACPI] not running any scripts
Content-Type: message/rfc822

Received: (qmail 21059 invoked by uid 509); 5 Jul 2005 20:24:15 -0000
Received: from acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org by
	jeeves.cse.iitb.ac.in by uid 507 with qmail-scanner-1.22-st-qms
	(clamdscan: 0.73. spamassassin: 2.63.
	Clear:RC:0(10.209.3.2):SA:0(-8.5/5.0):.  Processed in 0.108397 secs); 05
	Jul 2005 20:24:15 -0000
X-Spam-Status: No, hits=-8.5 required=5.0
X-Antivirus-cse.iitb.ac.in-Mail-From: 
	acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org via jeeves.cse.iitb.ac.in
X-Antivirus-cse.iitb.ac.in: 1.22-st-qms
	(Clear:RC:0(10.209.3.2):SA:0(-8.5/5.0):. Processed in 0.108397 secs Process
	21052)
Received: from mailrly2.iitb.ac.in (10.209.3.2) by cse.iitb.ac.in with
	SMTP; 5 Jul 2005 20:24:15 -0000
Received: (qmail 17559 invoked by uid 510); 5 Jul 2005 20:25:56 -0000
Received: from 66.35.250.225 by mailrly2 (envelope-from
	<acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, uid 501) with qmail-scanner-1.25
	(clamdscan: 0.85.1/967. spamassassin: 3.0.2.  
	Clear:RC:0(66.35.250.225):SA:0(-2.6/5.0):.  Processed in 4.687086 secs); 05
	Jul 2005 20:25:56 -0000
Received: from unknown (HELO lists-outbound.sourceforge.net)
	(66.35.250.225) by mailrly2.iitb.ac.in with SMTP; 5 Jul 2005 20:25:51 -0000
Received-SPF: pass (mailrly2.iitb.ac.in: SPF record at
	lists.sourceforge.net designates 66.35.250.225 as permitted sender)
Received: from projects.sourceforge.net (sc8-sf-list2-b.sourceforge.net
	[10.3.1.8]) by sc8-sf-spam2.sourceforge.net (Postfix) with ESMTP id
	C02D3120D1; Tue,  5 Jul 2005 13:25:48 -0700 (PDT)
Received: from [10.3.1.92] (helo=sc8-sf-mx2-new.sourceforge.net) by
	sc8-sf-list2.sourceforge.net with esmtp (Exim 4.30) id 1DpttR-0000Vx-Uu for
	acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Tue, 05 Jul 2005 13:19:45 -0700
Received: from smtp2.iitb.ac.in ([203.197.74.149] helo=smtp1.iitb.ac.in) by
	sc8-sf-mx2-new.sourceforge.net with smtp (Exim 4.44) id 1DpttQ-0001rE-5q
	for acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Tue, 05 Jul 2005 13:19:45 -0700
Received: (qmail 30146 invoked from network); 6 Jul 2005 01:49:32 +0530
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.12.1) by
	smtp1.iitb.ac.in with SMTP; 6 Jul 2005 01:49:32 +0530
Received: (qmail 11165 invoked by uid 509); 5 Jul 2005 20:14:43 -0000
Received: from 10.4.3.11 by ldns1 (envelope-from
	<agrawal_rocky-IRBnI7/bi/yuj8VC67ciSw@public.gmane.org>, uid 501) with qmail-scanner-1.25
	(clamdscan: 0.85.1/967. spamassassin: 3.0.2.   Clear:RC:1(10.4.3.11):.
	Processed in 0.01097 secs); 05 Jul 2005 20:14:43 -0000
Received: from unknown (HELO ?10.4.3.11?) (10.4.3.11) by ldns1.iitb.ac.in
	with SMTP; 5 Jul 2005 20:14:43 -0000
From: Rohit K Jhunjhunwala <agrawal_rocky-IRBnI7/bi/yuj8VC67ciSw@public.gmane.org>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Type: text/plain
Message-Id: <1120595098.4012.3.camel@roxie>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net. See
	http://spamassassin.org/tag/ for more details. Report problems to
	http://sf.net/tracker/?func=add&group_id=1&atid=200001 0.0
	SF_CHICKENPOX_SLASH    BODY: Text interparsed with / 0.0
	SF_CHICKENPOX_MINUS    BODY: Text interparsed with -
Subject: [ACPI] not running any scripts
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-BeenThere: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Id: ACPI Development Discussion List <acpi-devel.lists.sourceforge.net>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
X-Original-Date: Wed, 06 Jul 2005 01:54:58 +0530
Date: Wed, 06 Jul 2005 01:54:58 +0530
Content-Transfer-Encoding: 7bit

Hi,
I am running fedora core 2 on a Dell Inspiron 5150. I have acpi
installed as my kernel version is 2.6.10
I have written scripts and events in /etc/acpi/events but none of them
get executed
the state files in /proc/acpi/button does change when i close my lid
etc.
but the scripts are not executed.
Also, I am not able to put my computer in stand-by mode even manually.

I also tried rebuilding kernel with all acpi support.
but no use.
can anyone guide me on this




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=-ongW+AUNoeNc5EFo8x86--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
